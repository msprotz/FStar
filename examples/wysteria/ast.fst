(*--build-config
    options:--admit_fsi FStar.OrdSet --admit_fsi FStar.OrdMap;
    other-files:ordset.fsi ordmap.fsi
 --*)

module AST

open FStar.OrdMap

open FStar.OrdSet

type other_info = nat

type varname = string

type prin = nat

val p_cmp: prin -> prin -> Tot bool
let p_cmp p1 p2 = p1 <= p2

type prins = s:ordset prin p_cmp{not (s = empty)}

type eprins = ordset prin p_cmp

val ps_cmp: ps1:eprins -> ps2:eprins -> Tot bool (decreases (size ps1))
let rec ps_cmp ps1 ps2 =
  if size ps1 < size ps2 then false
  else if size ps1 > size ps2 then true
  else
    if ps1 = empty && ps2 = empty then true
    else
      let Some p1, Some p2 = choose ps1, choose ps2 in
      let ps1_rest, ps2_rest = remove p1 ps1, remove p2 ps2 in
      if p1 = p2 then ps_cmp ps1_rest ps2_rest
      else p_cmp p1 p2

val ps_cmp_antisymm:
  ps1:eprins -> ps2:eprins
  -> Lemma (requires (True)) (ensures ((ps_cmp ps1 ps2 /\ ps_cmp ps2 ps1) ==> ps1 = ps2))
     (decreases (size ps1))
let rec ps_cmp_antisymm ps1 ps2 =
  if ps1 = empty || ps2 = empty then ()
  else
    let Some p1, Some p2 = choose ps1, choose ps2 in
    let ps1_rest, ps2_rest = remove p1 ps1, remove p2 ps2 in
    ps_cmp_antisymm ps1_rest ps2_rest

val ps_cmp_trans:
  ps1:eprins -> ps2:eprins -> ps3:eprins
  -> Lemma (requires (True)) (ensures ((ps_cmp ps1 ps2 /\ ps_cmp ps2 ps3) ==> ps_cmp ps1 ps3))
     (decreases (size ps1))
let rec ps_cmp_trans ps1 ps2 ps3 =
  if ps1 = empty || ps2 = empty || ps3 = empty then ()
  else
    let Some p1, Some p2, Some p3 = choose ps1, choose ps2, choose ps3 in
    let ps1_rest, ps2_rest, ps3_rest = remove p1 ps1, remove p2 ps2, remove p3 ps3 in
    ps_cmp_trans ps1_rest ps2_rest ps3_rest

val ps_cmp_total:
  ps1:eprins -> ps2:eprins
  -> Lemma (requires (True)) (ensures (ps_cmp ps1 ps2 \/ ps_cmp ps2 ps1))
     (decreases (size ps1))
let rec ps_cmp_total ps1 ps2 =
  if ps1 = empty || ps2 = empty then ()
  else
    let Some p1, Some p2 = choose ps1, choose ps2 in
    let ps1_rest, ps2_rest = remove p1 ps1, remove p2 ps2 in
    ps_cmp_total ps1_rest ps2_rest

assume Ps_cmp_is_total_order: total_order prins ps_cmp

type const =
  | C_prin  : c:prin   -> const
  | C_eprins: c:eprins -> const
  | C_prins : c:prins  -> const

  | C_unit : const
  | C_nat  : c:nat  -> const
  | C_bool : c:bool -> const

type exp' =
  | E_aspar     : ps:exp -> e:exp -> exp'
  | E_assec     : ps:exp -> e:exp -> exp'
  | E_box       : ps:exp -> e:exp -> exp'
  | E_unbox     : e:exp  -> exp'
  | E_mkwire    : e1:exp -> e2:exp -> exp'
  | E_projwire  : e1:exp -> e2:exp -> exp'
  | E_concatwire: e1:exp -> e2:exp -> exp'

  | E_const     : c:const -> exp'
  | E_var       : x:varname -> exp'
  | E_let       : x:varname -> e1:exp -> e2:exp -> exp'
  | E_abs       : x:varname -> e:exp -> exp'
  | E_fix       : f:varname -> x:varname -> e:exp -> exp'
  | E_empabs    : x:varname -> e:exp -> exp'
  | E_app       : e1:exp -> e2:exp -> exp'
  | E_ffi       : fn:string -> args:list exp -> exp'
  | E_match     : e:exp -> pats:list (pat * exp) -> exp'

and pat =
  | P_const: c:const -> pat

and exp =
  | Exp: e:exp' -> info:option other_info -> exp

type canbox = | Can_b | Cannot_b

type canwire = | Can_w | Cannot_w

(*val canbox_const: c:const -> Tot canbox
let canbox_const c = match c with
  | C_prin _
  | C_prins _ -> Cannot_b
  
  | C_unit
  | C_nat _
  | C_bool _  -> Can_b*)

type v_meta =
  | Meta: vps:eprins -> cb:canbox -> wps:eprins -> cw:canwire -> v_meta

val is_meta_wireable: meta:v_meta -> Tot bool
let is_meta_wireable = function
  | Meta ps Can_b ps' Can_w -> ps = empty && ps' = empty
  | _                       -> false

val is_meta_boxable: ps:prins -> meta:v_meta -> Tot bool
let is_meta_boxable ps = function
  | Meta ps' Can_b ps'' _ -> subset ps' ps && subset ps'' ps
  | _                     -> false

type value: v_meta -> Type =
  | V_const   : c:const -> value (Meta empty Can_b empty Can_w)

  | V_box     : #meta:v_meta -> ps:prins -> v:value meta{is_meta_boxable ps meta}
                -> value (Meta ps Can_b (Meta.wps meta) Cannot_w)
                
  | V_wire    : eps:eprins -> m:v_wire eps
                -> value (Meta empty Can_b eps Cannot_w)

  | V_clos    : en:env -> x:varname -> e:exp
                -> value (Meta empty Cannot_b empty Cannot_w)
  
  | V_fix_clos: en:env -> f:varname -> x:varname -> e:exp
                -> value (Meta empty Cannot_b empty Cannot_w)

  | V_emp_clos: x:varname -> e:exp -> value (Meta empty Can_b empty Can_w)

  (* bomb value, comes up in target only *)
  | V_emp     : value (Meta empty Can_b empty Can_w)

and v_wire (eps:eprins) =
  m:ordmap prin (value (Meta empty Can_b empty Can_w)) p_cmp{forall p. mem p eps = contains p m}

and dvalue:Type =
  | D_v: meta:v_meta -> v:value meta -> dvalue

and env = varname -> Tot (option dvalue)

assume val preceds_axiom: en:env -> x:varname -> Lemma (ensures (en x << en))

type redex =
  | R_aspar     : #meta:v_meta -> ps:prins -> v:value meta -> redex
  | R_assec     : #meta:v_meta -> ps:prins -> v:value meta -> redex
  | R_box       : #meta:v_meta -> ps:prins -> v:value meta -> redex
  | R_unbox     : #meta:v_meta -> v:value meta -> redex
  | R_mkwire    : #mps:v_meta -> #mv:v_meta -> vps:value mps -> v:value mv -> redex
  | R_projwire  : #meta:v_meta -> p:prin -> v:value meta -> redex
  | R_concatwire: #meta1:v_meta -> #meta2:v_meta -> v1:value meta1 -> v2:value meta2 -> redex
  | R_let       : #meta:v_meta -> x:varname -> v:value meta -> e:exp -> redex
  | R_app       : #meta1:v_meta -> #meta2:v_meta -> v1:value meta1 -> v2:value meta2
                  -> redex
  | R_ffi       : fn:string -> args:list dvalue -> redex
  | R_match     : #meta:v_meta -> v:value meta -> pats:list (pat * exp) -> redex

val empty_env: env
let empty_env = fun _ -> None

val update_env: #meta:v_meta -> env -> varname -> value meta -> Tot env
let update_env #meta en x v = fun y -> if y = x then Some (D_v meta v) else en y

type as_mode =
  | Par
  | Sec

type mode =
  | Mode: m:as_mode -> ps:prins -> mode

type frame' =
  | F_aspar_ps     : e:exp -> frame'
  | F_aspar_e      : ps:prins -> frame'
  | F_aspar_ret    : ps:prins -> frame'
  | F_assec_ps     : e:exp -> frame'
  | F_assec_e      : ps:prins -> frame'
  | F_assec_ret    : frame'
  | F_box_ps       : e:exp -> frame'
  | F_box_e        : ps:prins -> frame'
  | F_unbox        : frame'
  | F_mkwire_ps    : e:exp -> frame'
  | F_mkwire_e     : #meta:v_meta -> v:value meta -> frame'
  | F_projwire_p   : e:exp -> frame'
  | F_projwire_e   : p:prin -> frame'
  | F_concatwire_e1: e:exp -> frame'
  | F_concatwire_e2: #meta:v_meta -> v:value meta -> frame'
  | F_let          : x:varname -> e2:exp -> frame'
  | F_app_e1       : e2:exp -> frame'
  | F_app_e2       : #meta:v_meta -> v:value meta -> frame'
  | F_ffi          : fn:string -> es:list exp -> vs:list dvalue -> frame'
  | F_match        : pats:list (pat * exp) -> frame'

type frame =
  | Frame: m:mode -> en:env -> f:frame'-> frame

type stack = list frame

type term =
  | T_exp     : e:exp -> term
  | T_red     : r:redex -> term
  | T_val     : #meta:v_meta -> v:value meta -> term

  | T_sec_wait: term

type level = | Source | Target

val src: level -> Tot bool
let src l = is_Source l

(* TODO: FIXME: workaround for projectors *)
val m_of_mode: mode -> Tot as_mode
let m_of_mode (Mode m _) = m

type mode_inv (m:mode) (l:level) =
  (is_Target l /\ m_of_mode m = Par) ==> is_singleton (Mode.ps m)

val is_sec_frame: f':frame' -> Tot bool
let is_sec_frame f' =
  not (is_F_aspar_ps f' || is_F_aspar_e f' || is_F_aspar_ret f')

(* TODO: FIXME: workaround for projectors *)
val ps_of_aspar_ret_frame: f':frame'{is_F_aspar_ret f'} -> Tot prins
let ps_of_aspar_ret_frame (F_aspar_ret ps) = ps

val stack_source_inv: stack -> mode -> Tot bool
let rec stack_source_inv s (Mode as_m ps) = match s with
  | []                  -> not (as_m = Sec)
  | (Frame m' _ f')::tl ->
    let Mode as_m' ps' = m' in
    (not (as_m = Par) || as_m' = Par)                              &&
    (not (as_m = Par) || not (is_F_assec_ret f'))                  &&
    (not (as_m = Sec) || (not (as_m' = Par) || is_F_assec_ret f')) &&
    (not (as_m' = Sec) || (is_sec_frame f' && is_Cons tl))         &&
    (not (is_F_aspar_ret f') || (ps = ps_of_aspar_ret_frame f'))   &&
    (ps = ps' || (subset ps ps' && is_F_aspar_ret f'))             &&
    stack_source_inv tl m'

val stack_target_inv: stack -> mode -> Tot bool
let rec stack_target_inv s m = match s with
  | []                  -> true
  | (Frame m' _ f')::tl ->
    m = m'                                             &&
    (not (m_of_mode m' = Par) || not (is_F_assec_ret f')) &&
    (not (m_of_mode m' = Sec) || is_sec_frame f')         &&
    stack_target_inv tl m

val stack_inv: stack -> mode -> level -> Tot bool
let rec stack_inv s m l =
  if is_Source l then stack_source_inv s m else stack_target_inv s m

val is_sec_redex: redex -> Tot bool
let is_sec_redex r = not (is_R_aspar r) //|| is_R_box r)

(* TODO: FIXME: workaround for projectors *)
val r_of_t_red: t:term{is_T_red t} -> Tot redex
let r_of_t_red (T_red r) = r

val term_inv: term -> mode -> level -> Tot bool
let term_inv t m l =
  (not (is_Source l) || not (t = T_sec_wait)) &&
  (not (is_T_red t && m_of_mode m = Sec) || is_sec_redex (r_of_t_red t))

type config =
  | Conf: l:level -> m:mode{mode_inv m l} -> s:stack{stack_inv s m l}
          -> en:env -> t:term{term_inv t m l} -> config

type sconfig = c:config{is_Source (Conf.l c)}
type tconfig = c:config{is_Target (Conf.l c)}

(* TODO: FIXME: workaround for projectors *)
val f_of_frame: frame -> Tot frame'
let f_of_frame (Frame _ _ f) = f

(* TODO: FIXME: workaround for projectors *)
val hd_of_list: l:list 'a{is_Cons l} -> Tot 'a
let hd_of_list (Cons hd _) = hd

val is_sframe: c:config -> f:(frame' -> Tot bool) -> Tot bool
let is_sframe (Conf _ _ s _ _) f = is_Cons s && f (f_of_frame (hd_of_list s))

(* TODO: FIXME: workaround for projectors *)
val t_of_conf: config -> Tot term
let t_of_conf (Conf _ _ _ _ t) = t

val is_value: c:config -> Tot bool
let is_value c = is_T_val (t_of_conf c)

val is_value_ps: c:config -> Tot bool
let is_value_ps c = match c with
  | Conf _ _ _ _ (T_val (V_const (C_prins _))) -> true
  | _                                          -> false

val is_value_p: c:config -> Tot bool
let is_value_p c = match c with
  | Conf _ _ _ _ (T_val (V_const (C_prin _))) -> true
  | _                                         -> false

val c_value: c:config{is_value c} -> Tot dvalue
let c_value (Conf _ _ _ _ (T_val #meta v)) = D_v meta v

val c_value_ps: c:config{is_value_ps c} -> Tot prins
let c_value_ps c = match c with
  | Conf _ _ _ _ (T_val (V_const (C_prins ps))) -> ps

val c_value_p: c:config{is_value_p c} -> Tot prin
let c_value_p c = match c with
  | Conf _ _ _ _ (T_val (V_const (C_prin p))) -> p

(* TODO: FIXME: workaround for projectors *)
val m_of_conf: config-> Tot mode
let m_of_conf (Conf _ m _ _ _) = m

val is_par: config -> Tot bool
let is_par c = is_Par (m_of_mode (m_of_conf c))

val is_sec: config -> Tot bool
let is_sec c = is_Sec (m_of_mode (m_of_conf c))

(* TODO: FIXME: the discriminators should take extra args for type indices *)
val is_clos: #meta:v_meta -> value meta -> Tot bool
let is_clos #meta v = match v with//is_V_clos v || is_V_fix_clos v || is_V_emp_clos v
  | V_clos _ _ _
  | V_emp_clos _ _
  | V_fix_clos _ _ _ _ -> true
  | _                  -> false

val get_en_b: #meta:v_meta -> v:value meta{is_clos v} -> Tot (env * varname * exp)
let get_en_b #meta v = match v with
  | V_clos en x e       -> en, x, e
  | V_fix_clos en f x e ->
    update_env #(Meta empty Cannot_b empty Cannot_w) en f (V_fix_clos en f x e), x, e
  | V_emp_clos x e      -> empty_env, x, e

val is_terminal: config -> Tot bool
let is_terminal (Conf _ _ s _ t) = s = [] && is_T_val t
