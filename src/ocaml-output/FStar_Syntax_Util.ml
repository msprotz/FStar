open Prims
let qual_id : FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident =
  fun lid  ->
    fun id  ->
      let uu____7 =
        FStar_Ident.lid_of_ids
          (FStar_List.append lid.FStar_Ident.ns [lid.FStar_Ident.ident; id])
         in
      FStar_Ident.set_lid_range uu____7 id.FStar_Ident.idRange
  
let mk_discriminator : FStar_Ident.lident -> FStar_Ident.lident =
  fun lid  ->
    FStar_Ident.lid_of_ids
      (FStar_List.append lid.FStar_Ident.ns
         [FStar_Ident.mk_ident
            ((Prims.strcat FStar_Ident.reserved_prefix
                (Prims.strcat "is_"
                   (lid.FStar_Ident.ident).FStar_Ident.idText)),
              ((lid.FStar_Ident.ident).FStar_Ident.idRange))])
  
let is_name : FStar_Ident.lident -> Prims.bool =
  fun lid  ->
    let c =
      FStar_Util.char_at (lid.FStar_Ident.ident).FStar_Ident.idText
        (Prims.parse_int "0")
       in
    FStar_Util.is_upper c
  
let arg_of_non_null_binder uu____25 =
  match uu____25 with
  | (b,imp) ->
      let uu____30 = FStar_Syntax_Syntax.bv_to_name b  in (uu____30, imp)
  
let args_of_non_null_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____43 = FStar_Syntax_Syntax.is_null_binder b  in
            if uu____43
            then []
            else (let uu____50 = arg_of_non_null_binder b  in [uu____50])))
  
let args_of_binders :
  FStar_Syntax_Syntax.binders ->
    ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list *
      (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.aqual) Prims.list)
  =
  fun binders  ->
    let uu____64 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____86 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____86
              then
                let b1 =
                  let uu____96 =
                    FStar_Syntax_Syntax.new_bv None
                      (fst b).FStar_Syntax_Syntax.sort
                     in
                  (uu____96, (snd b))  in
                let uu____97 = arg_of_non_null_binder b1  in (b1, uu____97)
              else
                (let uu____105 = arg_of_non_null_binder b  in (b, uu____105))))
       in
    FStar_All.pipe_right uu____64 FStar_List.unzip
  
let name_binders :
  FStar_Syntax_Syntax.binder Prims.list ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____145 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____145
              then
                let uu____148 = b  in
                match uu____148 with
                | (a,imp) ->
                    let b1 =
                      let uu____154 =
                        let uu____155 = FStar_Util.string_of_int i  in
                        Prims.strcat "_" uu____155  in
                      FStar_Ident.id_of_text uu____154  in
                    let b2 =
                      {
                        FStar_Syntax_Syntax.ppname = b1;
                        FStar_Syntax_Syntax.index = (Prims.parse_int "0");
                        FStar_Syntax_Syntax.sort =
                          (a.FStar_Syntax_Syntax.sort)
                      }  in
                    (b2, imp)
              else b))
  
let name_function_binders t =
  match t.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
      let uu____183 =
        let uu____186 =
          let uu____187 =
            let uu____195 = name_binders binders  in (uu____195, comp)  in
          FStar_Syntax_Syntax.Tm_arrow uu____187  in
        FStar_Syntax_Syntax.mk uu____186  in
      uu____183 None t.FStar_Syntax_Syntax.pos
  | uu____212 -> t 
let null_binders_of_tks :
  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____232  ->
            match uu____232 with
            | (t,imp) ->
                let uu____239 =
                  let uu____240 = FStar_Syntax_Syntax.null_binder t  in
                  FStar_All.pipe_left FStar_Pervasives.fst uu____240  in
                (uu____239, imp)))
  
let binders_of_tks :
  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____266  ->
            match uu____266 with
            | (t,imp) ->
                let uu____279 =
                  FStar_Syntax_Syntax.new_bv
                    (Some (t.FStar_Syntax_Syntax.pos)) t
                   in
                (uu____279, imp)))
  
let binders_of_freevars :
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list
  =
  fun fvs  ->
    let uu____286 = FStar_Util.set_elements fvs  in
    FStar_All.pipe_right uu____286
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
  
let mk_subst s = [s] 
let subst_of_list :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.subst_t
  =
  fun formals  ->
    fun actuals  ->
      if (FStar_List.length formals) = (FStar_List.length actuals)
      then
        FStar_List.fold_right2
          (fun f  ->
             fun a  ->
               fun out  -> (FStar_Syntax_Syntax.NT ((fst f), (fst a))) :: out)
          formals actuals []
      else failwith "Ill-formed substitution"
  
let rename_binders :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.subst_t
  =
  fun replace_xs  ->
    fun with_ys  ->
      if (FStar_List.length replace_xs) = (FStar_List.length with_ys)
      then
        FStar_List.map2
          (fun uu____354  ->
             fun uu____355  ->
               match (uu____354, uu____355) with
               | ((x,uu____365),(y,uu____367)) ->
                   let uu____372 =
                     let uu____377 = FStar_Syntax_Syntax.bv_to_name y  in
                     (x, uu____377)  in
                   FStar_Syntax_Syntax.NT uu____372) replace_xs with_ys
      else failwith "Ill-formed substitution"
  
let rec unmeta : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e2,uu____384) -> unmeta e2
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____390,uu____391) -> unmeta e2
    | uu____420 -> e1
  
let rec univ_kernel :
  FStar_Syntax_Syntax.universe -> (FStar_Syntax_Syntax.universe * Prims.int)
  =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_name uu____428 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_unif uu____429 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_zero  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____433 = univ_kernel u1  in
        (match uu____433 with | (k,n1) -> (k, (n1 + (Prims.parse_int "1"))))
    | FStar_Syntax_Syntax.U_max uu____440 ->
        failwith "Imposible: univ_kernel (U_max _)"
    | FStar_Syntax_Syntax.U_bvar uu____444 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
  
let constant_univ_as_nat : FStar_Syntax_Syntax.universe -> Prims.int =
  fun u  -> let uu____450 = univ_kernel u  in snd uu____450 
let rec compare_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int =
  fun u1  ->
    fun u2  ->
      match (u1, u2) with
      | (FStar_Syntax_Syntax.U_bvar uu____459,uu____460) ->
          failwith "Impossible: compare_univs"
      | (uu____461,FStar_Syntax_Syntax.U_bvar uu____462) ->
          failwith "Impossible: compare_univs"
      | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_unknown ,uu____463) ->
          ~- (Prims.parse_int "1")
      | (uu____464,FStar_Syntax_Syntax.U_unknown ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_zero ,uu____465) -> ~- (Prims.parse_int "1")
      | (uu____466,FStar_Syntax_Syntax.U_zero ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_name u11,FStar_Syntax_Syntax.U_name u21) ->
          FStar_String.compare u11.FStar_Ident.idText u21.FStar_Ident.idText
      | (FStar_Syntax_Syntax.U_name uu____469,FStar_Syntax_Syntax.U_unif
         uu____470) -> ~- (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif uu____473,FStar_Syntax_Syntax.U_name
         uu____474) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif u11,FStar_Syntax_Syntax.U_unif u21) ->
          let uu____483 = FStar_Syntax_Unionfind.univ_uvar_id u11  in
          let uu____484 = FStar_Syntax_Unionfind.univ_uvar_id u21  in
          uu____483 - uu____484
      | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
          let n1 = FStar_List.length us1  in
          let n2 = FStar_List.length us2  in
          if n1 <> n2
          then n1 - n2
          else
            (let copt =
               let uu____505 = FStar_List.zip us1 us2  in
               FStar_Util.find_map uu____505
                 (fun uu____511  ->
                    match uu____511 with
                    | (u11,u21) ->
                        let c = compare_univs u11 u21  in
                        if c <> (Prims.parse_int "0") then Some c else None)
                in
             match copt with | None  -> (Prims.parse_int "0") | Some c -> c)
      | (FStar_Syntax_Syntax.U_max uu____521,uu____522) ->
          ~- (Prims.parse_int "1")
      | (uu____524,FStar_Syntax_Syntax.U_max uu____525) ->
          (Prims.parse_int "1")
      | uu____527 ->
          let uu____530 = univ_kernel u1  in
          (match uu____530 with
           | (k1,n1) ->
               let uu____535 = univ_kernel u2  in
               (match uu____535 with
                | (k2,n2) ->
                    let r = compare_univs k1 k2  in
                    if r = (Prims.parse_int "0") then n1 - n2 else r))
  
let eq_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool
  =
  fun u1  ->
    fun u2  ->
      let uu____548 = compare_univs u1 u2  in
      uu____548 = (Prims.parse_int "0")
  
let ml_comp :
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp
  =
  fun t  ->
    fun r  ->
      FStar_Syntax_Syntax.mk_Comp
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_unknown];
          FStar_Syntax_Syntax.effect_name =
            (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_ML_lid r);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }
  
let comp_effect_name c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c1 -> c1.FStar_Syntax_Syntax.effect_name
  | FStar_Syntax_Syntax.Total uu____575 -> FStar_Syntax_Const.effect_Tot_lid
  | FStar_Syntax_Syntax.GTotal uu____581 ->
      FStar_Syntax_Const.effect_GTot_lid
  
let comp_flags c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____599 -> [FStar_Syntax_Syntax.TOTAL]
  | FStar_Syntax_Syntax.GTotal uu____605 -> [FStar_Syntax_Syntax.SOMETRIVIAL]
  | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags 
let comp_set_flags :
  FStar_Syntax_Syntax.comp ->
    FStar_Syntax_Syntax.cflags Prims.list ->
      (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax
  =
  fun c  ->
    fun f  ->
      let comp_to_comp_typ c1 =
        match c1.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Comp c2 -> c2
        | FStar_Syntax_Syntax.Total (t,u_opt) ->
            let uu____635 =
              let uu____636 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
              FStar_Util.dflt [] uu____636  in
            {
              FStar_Syntax_Syntax.comp_univs = uu____635;
              FStar_Syntax_Syntax.effect_name = (comp_effect_name c1);
              FStar_Syntax_Syntax.result_typ = t;
              FStar_Syntax_Syntax.effect_args = [];
              FStar_Syntax_Syntax.flags = (comp_flags c1)
            }
        | FStar_Syntax_Syntax.GTotal (t,u_opt) ->
            let uu____654 =
              let uu____655 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
              FStar_Util.dflt [] uu____655  in
            {
              FStar_Syntax_Syntax.comp_univs = uu____654;
              FStar_Syntax_Syntax.effect_name = (comp_effect_name c1);
              FStar_Syntax_Syntax.result_typ = t;
              FStar_Syntax_Syntax.effect_args = [];
              FStar_Syntax_Syntax.flags = (comp_flags c1)
            }
         in
      let uu___174_665 = c  in
      let uu____666 =
        let uu____667 =
          let uu___175_668 = comp_to_comp_typ c  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___175_668.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___175_668.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___175_668.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___175_668.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          }  in
        FStar_Syntax_Syntax.Comp uu____667  in
      {
        FStar_Syntax_Syntax.n = uu____666;
        FStar_Syntax_Syntax.tk = (uu___174_665.FStar_Syntax_Syntax.tk);
        FStar_Syntax_Syntax.pos = (uu___174_665.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___174_665.FStar_Syntax_Syntax.vars)
      }
  
let comp_to_comp_typ :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | uu____699 ->
        failwith "Assertion failed: Computation type without universe"
  
let is_named_tot c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c1 ->
      FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
        FStar_Syntax_Const.effect_Tot_lid
  | FStar_Syntax_Syntax.Total uu____712 -> true
  | FStar_Syntax_Syntax.GTotal uu____718 -> false 
let is_total_comp c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___162_736  ->
          match uu___162_736 with
          | FStar_Syntax_Syntax.TOTAL  -> true
          | FStar_Syntax_Syntax.RETURN  -> true
          | uu____737 -> false))
  
let is_total_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
       FStar_Syntax_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___163_742  ->
               match uu___163_742 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____743 -> false)))
  
let is_tot_or_gtot_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    ((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
        FStar_Syntax_Const.effect_Tot_lid)
       ||
       (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
          FStar_Syntax_Const.effect_GTot_lid))
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___164_748  ->
               match uu___164_748 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____749 -> false)))
  
let is_partial_return c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___165_762  ->
          match uu___165_762 with
          | FStar_Syntax_Syntax.RETURN  -> true
          | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
          | uu____763 -> false))
  
let is_lcomp_partial_return : FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
      (FStar_Util.for_some
         (fun uu___166_768  ->
            match uu___166_768 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____769 -> false))
  
let is_tot_or_gtot_comp c =
  (is_total_comp c) ||
    (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid
       (comp_effect_name c))
  
let is_pure_effect : FStar_Ident.lident -> Prims.bool =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Tot_lid) ||
       (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_PURE_lid))
      || (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Pure_lid)
  
let is_pure_comp c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____795 -> true
  | FStar_Syntax_Syntax.GTotal uu____801 -> false
  | FStar_Syntax_Syntax.Comp ct ->
      ((is_total_comp c) ||
         (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
        ||
        (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
           (FStar_Util.for_some
              (fun uu___167_809  ->
                 match uu___167_809 with
                 | FStar_Syntax_Syntax.LEMMA  -> true
                 | uu____810 -> false)))
  
let is_ghost_effect : FStar_Ident.lident -> Prims.bool =
  fun l  ->
    ((FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid l) ||
       (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GHOST_lid l))
      || (FStar_Ident.lid_equals FStar_Syntax_Const.effect_Ghost_lid l)
  
let is_pure_or_ghost_comp c =
  (is_pure_comp c) || (is_ghost_effect (comp_effect_name c)) 
let is_pure_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun lc  ->
    ((is_total_lcomp lc) || (is_pure_effect lc.FStar_Syntax_Syntax.eff_name))
      ||
      (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___168_829  ->
               match uu___168_829 with
               | FStar_Syntax_Syntax.LEMMA  -> true
               | uu____830 -> false)))
  
let is_pure_or_ghost_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun lc  ->
    (is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)
  
let is_pure_or_ghost_function : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____837 =
      let uu____838 = FStar_Syntax_Subst.compress t  in
      uu____838.FStar_Syntax_Syntax.n  in
    match uu____837 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____841,c) -> is_pure_or_ghost_comp c
    | uu____853 -> true
  
let is_lemma_comp c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp ct ->
      FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
        FStar_Syntax_Const.effect_Lemma_lid
  | uu____866 -> false 
let is_lemma : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____870 =
      let uu____871 = FStar_Syntax_Subst.compress t  in
      uu____871.FStar_Syntax_Syntax.n  in
    match uu____870 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____874,c) -> is_lemma_comp c
    | uu____886 -> false
  
let head_and_args :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax *
      ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) -> (head1, args)
    | uu____932 -> (t1, [])
  
let rec head_and_args' :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term *
      ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) ->
        let uu____976 = head_and_args' head1  in
        (match uu____976 with
         | (head2,args') -> (head2, (FStar_List.append args' args)))
    | uu____1012 -> (t1, [])
  
let un_uinst : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____1027) ->
        FStar_Syntax_Subst.compress t2
    | uu____1032 -> t1
  
let is_smt_lemma : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1036 =
      let uu____1037 = FStar_Syntax_Subst.compress t  in
      uu____1037.FStar_Syntax_Syntax.n  in
    match uu____1036 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1040,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Syntax_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____1056)::uu____1057 ->
                  let pats' = unmeta pats  in
                  let uu____1088 = head_and_args pats'  in
                  (match uu____1088 with
                   | (head1,uu____1099) ->
                       let uu____1114 =
                         let uu____1115 = un_uinst head1  in
                         uu____1115.FStar_Syntax_Syntax.n  in
                       (match uu____1114 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Syntax_Const.cons_lid
                        | uu____1119 -> false))
              | uu____1120 -> false)
         | uu____1126 -> false)
    | uu____1127 -> false
  
let is_ml_comp c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c1 ->
      (FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
         FStar_Syntax_Const.effect_ML_lid)
        ||
        (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
           (FStar_Util.for_some
              (fun uu___169_1141  ->
                 match uu___169_1141 with
                 | FStar_Syntax_Syntax.MLEFFECT  -> true
                 | uu____1142 -> false)))
  | uu____1143 -> false 
let comp_result c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total (t,uu____1158) -> t
  | FStar_Syntax_Syntax.GTotal (t,uu____1166) -> t
  | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ 
let set_result_typ c t =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____1190 -> FStar_Syntax_Syntax.mk_Total t
  | FStar_Syntax_Syntax.GTotal uu____1196 -> FStar_Syntax_Syntax.mk_GTotal t
  | FStar_Syntax_Syntax.Comp ct ->
      FStar_Syntax_Syntax.mk_Comp
        (let uu___176_1203 = ct  in
         {
           FStar_Syntax_Syntax.comp_univs =
             (uu___176_1203.FStar_Syntax_Syntax.comp_univs);
           FStar_Syntax_Syntax.effect_name =
             (uu___176_1203.FStar_Syntax_Syntax.effect_name);
           FStar_Syntax_Syntax.result_typ = t;
           FStar_Syntax_Syntax.effect_args =
             (uu___176_1203.FStar_Syntax_Syntax.effect_args);
           FStar_Syntax_Syntax.flags =
             (uu___176_1203.FStar_Syntax_Syntax.flags)
         })
  
let is_trivial_wp c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___170_1216  ->
          match uu___170_1216 with
          | FStar_Syntax_Syntax.TOTAL  -> true
          | FStar_Syntax_Syntax.RETURN  -> true
          | uu____1217 -> false))
  
let primops : FStar_Ident.lident Prims.list =
  [FStar_Syntax_Const.op_Eq;
  FStar_Syntax_Const.op_notEq;
  FStar_Syntax_Const.op_LT;
  FStar_Syntax_Const.op_LTE;
  FStar_Syntax_Const.op_GT;
  FStar_Syntax_Const.op_GTE;
  FStar_Syntax_Const.op_Subtraction;
  FStar_Syntax_Const.op_Minus;
  FStar_Syntax_Const.op_Addition;
  FStar_Syntax_Const.op_Multiply;
  FStar_Syntax_Const.op_Division;
  FStar_Syntax_Const.op_Modulus;
  FStar_Syntax_Const.op_And;
  FStar_Syntax_Const.op_Or;
  FStar_Syntax_Const.op_Negation] 
let is_primop_lid : FStar_Ident.lident -> Prims.bool =
  fun l  ->
    FStar_All.pipe_right primops
      (FStar_Util.for_some (FStar_Ident.lid_equals l))
  
let is_primop f =
  match f.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_fvar fv ->
      is_primop_lid (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  | uu____1239 -> false 
let rec unascribe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____1245,uu____1246) ->
        unascribe e2
    | uu____1275 -> e1
  
let rec ascribe t k =
  match t.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_ascribed (t',uu____1317,uu____1318) ->
      ascribe t' k
  | uu____1347 ->
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (t, k, None))
        None t.FStar_Syntax_Syntax.pos
  
type eq_result =
  | Equal 
  | NotEqual 
  | Unknown 
let uu___is_Equal : eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____1369 -> false
  
let uu___is_NotEqual : eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____1373 -> false
  
let uu___is_Unknown : eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____1377 -> false
  
let rec eq_tm :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> eq_result =
  fun t1  ->
    fun t2  ->
      let canon_app t =
        let uu____1398 =
          let uu____1406 = unascribe t  in head_and_args' uu____1406  in
        match uu____1398 with
        | (hd1,args) ->
            FStar_Syntax_Syntax.mk_Tm_app hd1 args None
              t.FStar_Syntax_Syntax.pos
         in
      let t11 = canon_app t1  in
      let t21 = canon_app t2  in
      let equal_if uu___171_1432 = if uu___171_1432 then Equal else Unknown
         in
      let equal_iff uu___172_1437 = if uu___172_1437 then Equal else NotEqual
         in
      let eq_and f g = match f with | Equal  -> g () | uu____1451 -> Unknown
         in
      let eq_inj f g =
        match (f, g) with
        | (Equal ,Equal ) -> Equal
        | (NotEqual ,uu____1459) -> NotEqual
        | (uu____1460,NotEqual ) -> NotEqual
        | (Unknown ,uu____1461) -> Unknown
        | (uu____1462,Unknown ) -> Unknown  in
      match ((t11.FStar_Syntax_Syntax.n), (t21.FStar_Syntax_Syntax.n)) with
      | (FStar_Syntax_Syntax.Tm_name a,FStar_Syntax_Syntax.Tm_name b) ->
          equal_if (FStar_Syntax_Syntax.bv_eq a b)
      | (FStar_Syntax_Syntax.Tm_fvar f,FStar_Syntax_Syntax.Tm_fvar g) ->
          let uu____1467 = FStar_Syntax_Syntax.fv_eq f g  in
          equal_if uu____1467
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____1480 = eq_tm f g  in
          eq_and uu____1480
            (fun uu____1481  ->
               let uu____1482 = eq_univs_list us vs  in equal_if uu____1482)
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____1485 = FStar_Const.eq_const c d  in equal_iff uu____1485
      | (FStar_Syntax_Syntax.Tm_uvar
         (u1,uu____1487),FStar_Syntax_Syntax.Tm_uvar (u2,uu____1489)) ->
          let uu____1514 = FStar_Syntax_Unionfind.equiv u1 u2  in
          equal_if uu____1514
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____1547 =
            let uu____1550 =
              let uu____1551 = un_uinst h1  in
              uu____1551.FStar_Syntax_Syntax.n  in
            let uu____1554 =
              let uu____1555 = un_uinst h2  in
              uu____1555.FStar_Syntax_Syntax.n  in
            (uu____1550, uu____1554)  in
          (match uu____1547 with
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (f1.FStar_Syntax_Syntax.fv_qual =
                  (Some FStar_Syntax_Syntax.Data_ctor))
                 &&
                 (f2.FStar_Syntax_Syntax.fv_qual =
                    (Some FStar_Syntax_Syntax.Data_ctor))
               ->
               let uu____1562 = FStar_Syntax_Syntax.fv_eq f1 f2  in
               if uu____1562
               then
                 let uu____1564 = FStar_List.zip args1 args2  in
                 FStar_All.pipe_left
                   (FStar_List.fold_left
                      (fun acc  ->
                         fun uu____1594  ->
                           match uu____1594 with
                           | ((a1,q1),(a2,q2)) ->
                               let uu____1610 = eq_tm a1 a2  in
                               eq_inj acc uu____1610) Equal) uu____1564
               else NotEqual
           | uu____1612 ->
               let uu____1615 = eq_tm h1 h2  in
               eq_and uu____1615 (fun uu____1616  -> eq_args args1 args2))
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v1) ->
          let uu____1619 = eq_univs u v1  in equal_if uu____1619
      | (FStar_Syntax_Syntax.Tm_meta (t12,uu____1621),uu____1622) ->
          eq_tm t12 t21
      | (uu____1627,FStar_Syntax_Syntax.Tm_meta (t22,uu____1629)) ->
          eq_tm t11 t22
      | uu____1634 -> Unknown

and eq_args :
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____1658)::a11,(b,uu____1661)::b1) ->
          let uu____1699 = eq_tm a b  in
          (match uu____1699 with
           | Equal  -> eq_args a11 b1
           | uu____1700 -> Unknown)
      | uu____1701 -> Unknown

and eq_univs_list :
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.universes -> Prims.bool
  =
  fun us  ->
    fun vs  ->
      ((FStar_List.length us) = (FStar_List.length vs)) &&
        (FStar_List.forall2 eq_univs us vs)

let rec unrefine : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____1715) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____1721,uu____1722) ->
        unrefine t2
    | uu____1751 -> t1
  
let rec is_unit : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1755 =
      let uu____1756 = unrefine t  in uu____1756.FStar_Syntax_Syntax.n  in
    match uu____1755 with
    | FStar_Syntax_Syntax.Tm_type uu____1759 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) ||
          (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid)
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____1762) -> is_unit t1
    | uu____1767 -> false
  
let rec non_informative : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1771 =
      let uu____1772 = unrefine t  in uu____1772.FStar_Syntax_Syntax.n  in
    match uu____1771 with
    | FStar_Syntax_Syntax.Tm_type uu____1775 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid))
          || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.erased_lid)
    | FStar_Syntax_Syntax.Tm_app (head1,uu____1778) -> non_informative head1
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____1794) -> non_informative t1
    | FStar_Syntax_Syntax.Tm_arrow (uu____1799,c) ->
        (is_tot_or_gtot_comp c) && (non_informative (comp_result c))
    | uu____1811 -> false
  
let is_fun : FStar_Syntax_Syntax.term -> Prims.bool =
  fun e  ->
    let uu____1815 =
      let uu____1816 = FStar_Syntax_Subst.compress e  in
      uu____1816.FStar_Syntax_Syntax.n  in
    match uu____1815 with
    | FStar_Syntax_Syntax.Tm_abs uu____1819 -> true
    | uu____1829 -> false
  
let is_function_typ : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1833 =
      let uu____1834 = FStar_Syntax_Subst.compress t  in
      uu____1834.FStar_Syntax_Syntax.n  in
    match uu____1833 with
    | FStar_Syntax_Syntax.Tm_arrow uu____1837 -> true
    | uu____1845 -> false
  
let rec pre_typ : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____1851) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____1857,uu____1858) ->
        pre_typ t2
    | uu____1887 -> t1
  
let destruct :
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list
        option
  =
  fun typ  ->
    fun lid  ->
      let typ1 = FStar_Syntax_Subst.compress typ  in
      let uu____1901 =
        let uu____1902 = un_uinst typ1  in uu____1902.FStar_Syntax_Syntax.n
         in
      match uu____1901 with
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let head2 = un_uinst head1  in
          (match head2.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid -> Some args
           | uu____1940 -> None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid -> Some []
      | uu____1956 -> None
  
let lids_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let (uu____1967,lids,uu____1969) -> lids
    | FStar_Syntax_Syntax.Sig_bundle (uu____1974,lids) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ
        (lid,uu____1981,uu____1982,uu____1983,uu____1984,uu____1985) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_effect_abbrev
        (lid,uu____1991,uu____1992,uu____1993,uu____1994) -> [lid]
    | FStar_Syntax_Syntax.Sig_datacon
        (lid,uu____1998,uu____1999,uu____2000,uu____2001,uu____2002) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____2006,uu____2007) ->
        [lid]
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____2009) -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect_for_free n1 ->
        [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_new_effect n1 -> [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect uu____2012 -> []
    | FStar_Syntax_Syntax.Sig_pragma uu____2013 -> []
    | FStar_Syntax_Syntax.Sig_main uu____2014 -> []
  
let lid_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident option =
  fun se  ->
    match lids_of_sigelt se with | l::[] -> Some l | uu____2022 -> None
  
let quals_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list =
  fun x  -> x.FStar_Syntax_Syntax.sigquals 
let range_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Range.range =
  fun x  -> x.FStar_Syntax_Syntax.sigrng 
let range_of_lb uu___173_2044 =
  match uu___173_2044 with
  | (FStar_Util.Inl x,uu____2051,uu____2052) ->
      FStar_Syntax_Syntax.range_of_bv x
  | (FStar_Util.Inr l,uu____2056,uu____2057) -> FStar_Ident.range_of_lid l 
let range_of_arg uu____2074 =
  match uu____2074 with | (hd1,uu____2080) -> hd1.FStar_Syntax_Syntax.pos 
let range_of_args args r =
  FStar_All.pipe_right args
    (FStar_List.fold_left
       (fun r1  -> fun a  -> FStar_Range.union_ranges r1 (range_of_arg a)) r)
  
let mk_app f args =
  let r = range_of_args args f.FStar_Syntax_Syntax.pos  in
  FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args)) None r 
let mk_data l args =
  match args with
  | [] ->
      let uu____2194 =
        let uu____2197 =
          let uu____2198 =
            let uu____2203 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant
                (Some FStar_Syntax_Syntax.Data_ctor)
               in
            (uu____2203,
              (FStar_Syntax_Syntax.Meta_desugared
                 FStar_Syntax_Syntax.Data_app))
             in
          FStar_Syntax_Syntax.Tm_meta uu____2198  in
        FStar_Syntax_Syntax.mk uu____2197  in
      uu____2194 None (FStar_Ident.range_of_lid l)
  | uu____2212 ->
      let e =
        let uu____2221 =
          FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant
            (Some FStar_Syntax_Syntax.Data_ctor)
           in
        mk_app uu____2221 args  in
      FStar_Syntax_Syntax.mk
        (FStar_Syntax_Syntax.Tm_meta
           (e,
             (FStar_Syntax_Syntax.Meta_desugared FStar_Syntax_Syntax.Data_app)))
        None e.FStar_Syntax_Syntax.pos
  
let mangle_field_name : FStar_Ident.ident -> FStar_Ident.ident =
  fun x  ->
    FStar_Ident.mk_ident
      ((Prims.strcat "__fname__" x.FStar_Ident.idText),
        (x.FStar_Ident.idRange))
  
let unmangle_field_name : FStar_Ident.ident -> FStar_Ident.ident =
  fun x  ->
    if FStar_Util.starts_with x.FStar_Ident.idText "__fname__"
    then
      let uu____2236 =
        let uu____2239 =
          FStar_Util.substring_from x.FStar_Ident.idText
            (Prims.parse_int "9")
           in
        (uu____2239, (x.FStar_Ident.idRange))  in
      FStar_Ident.mk_ident uu____2236
    else x
  
let field_projector_prefix : Prims.string = "__proj__" 
let field_projector_sep : Prims.string = "__item__" 
let field_projector_contains_constructor : Prims.string -> Prims.bool =
  fun s  -> FStar_Util.starts_with s field_projector_prefix 
let mk_field_projector_name_from_string :
  Prims.string -> Prims.string -> Prims.string =
  fun constr  ->
    fun field  ->
      Prims.strcat field_projector_prefix
        (Prims.strcat constr (Prims.strcat field_projector_sep field))
  
let mk_field_projector_name_from_ident :
  FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident =
  fun lid  ->
    fun i  ->
      let j = unmangle_field_name i  in
      let jtext = j.FStar_Ident.idText  in
      let newi =
        if field_projector_contains_constructor jtext
        then j
        else
          FStar_Ident.mk_ident
            ((mk_field_projector_name_from_string
                (lid.FStar_Ident.ident).FStar_Ident.idText jtext),
              (i.FStar_Ident.idRange))
         in
      FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns [newi])
  
let mk_field_projector_name :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.bv ->
      Prims.int -> (FStar_Ident.lident * FStar_Syntax_Syntax.bv)
  =
  fun lid  ->
    fun x  ->
      fun i  ->
        let nm =
          let uu____2272 = FStar_Syntax_Syntax.is_null_bv x  in
          if uu____2272
          then
            let uu____2273 =
              let uu____2276 =
                let uu____2277 = FStar_Util.string_of_int i  in
                Prims.strcat "_" uu____2277  in
              let uu____2278 = FStar_Syntax_Syntax.range_of_bv x  in
              (uu____2276, uu____2278)  in
            FStar_Ident.mk_ident uu____2273
          else x.FStar_Syntax_Syntax.ppname  in
        let y =
          let uu___177_2281 = x  in
          {
            FStar_Syntax_Syntax.ppname = nm;
            FStar_Syntax_Syntax.index =
              (uu___177_2281.FStar_Syntax_Syntax.index);
            FStar_Syntax_Syntax.sort =
              (uu___177_2281.FStar_Syntax_Syntax.sort)
          }  in
        let uu____2282 = mk_field_projector_name_from_ident lid nm  in
        (uu____2282, y)
  
let set_uvar :
  FStar_Syntax_Syntax.uvar -> FStar_Syntax_Syntax.term -> Prims.unit =
  fun uv  ->
    fun t  ->
      let uu____2289 = FStar_Syntax_Unionfind.find uv  in
      match uu____2289 with
      | Some uu____2291 ->
          let uu____2292 =
            let uu____2293 =
              let uu____2294 = FStar_Syntax_Unionfind.uvar_id uv  in
              FStar_All.pipe_left FStar_Util.string_of_int uu____2294  in
            FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____2293  in
          failwith uu____2292
      | uu____2295 -> FStar_Syntax_Unionfind.change uv t
  
let qualifier_equal :
  FStar_Syntax_Syntax.qualifier ->
    FStar_Syntax_Syntax.qualifier -> Prims.bool
  =
  fun q1  ->
    fun q2  ->
      match (q1, q2) with
      | (FStar_Syntax_Syntax.Discriminator
         l1,FStar_Syntax_Syntax.Discriminator l2) ->
          FStar_Ident.lid_equals l1 l2
      | (FStar_Syntax_Syntax.Projector
         (l1a,l1b),FStar_Syntax_Syntax.Projector (l2a,l2b)) ->
          (FStar_Ident.lid_equals l1a l2a) &&
            (l1b.FStar_Ident.idText = l2b.FStar_Ident.idText)
      | (FStar_Syntax_Syntax.RecordType
         (ns1,f1),FStar_Syntax_Syntax.RecordType (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
                 f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
               f1 f2)
      | (FStar_Syntax_Syntax.RecordConstructor
         (ns1,f1),FStar_Syntax_Syntax.RecordConstructor (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
                 f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
               f1 f2)
      | uu____2357 -> q1 = q2
  
let abs :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.residual_comp option -> FStar_Syntax_Syntax.term
  =
  fun bs  ->
    fun t  ->
      fun lopt  ->
        let close_lopt lopt1 =
          match lopt1 with
          | None  -> None
          | Some rc ->
              let uu____2380 =
                let uu___178_2381 = rc  in
                let uu____2382 =
                  FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                    (FStar_Syntax_Subst.close bs)
                   in
                {
                  FStar_Syntax_Syntax.residual_effect =
                    (uu___178_2381.FStar_Syntax_Syntax.residual_effect);
                  FStar_Syntax_Syntax.residual_typ = uu____2382;
                  FStar_Syntax_Syntax.residual_flags =
                    (uu___178_2381.FStar_Syntax_Syntax.residual_flags)
                }  in
              Some uu____2380
           in
        match bs with
        | [] -> t
        | uu____2390 ->
            let body =
              let uu____2392 = FStar_Syntax_Subst.close bs t  in
              FStar_Syntax_Subst.compress uu____2392  in
            (match ((body.FStar_Syntax_Syntax.n), lopt) with
             | (FStar_Syntax_Syntax.Tm_abs (bs',t1,lopt'),None ) ->
                 let uu____2410 =
                   let uu____2413 =
                     let uu____2414 =
                       let uu____2424 =
                         let uu____2428 = FStar_Syntax_Subst.close_binders bs
                            in
                         FStar_List.append uu____2428 bs'  in
                       let uu____2434 = close_lopt lopt'  in
                       (uu____2424, t1, uu____2434)  in
                     FStar_Syntax_Syntax.Tm_abs uu____2414  in
                   FStar_Syntax_Syntax.mk uu____2413  in
                 uu____2410 None t1.FStar_Syntax_Syntax.pos
             | uu____2450 ->
                 let uu____2454 =
                   let uu____2457 =
                     let uu____2458 =
                       let uu____2468 = FStar_Syntax_Subst.close_binders bs
                          in
                       let uu____2469 = close_lopt lopt  in
                       (uu____2468, body, uu____2469)  in
                     FStar_Syntax_Syntax.Tm_abs uu____2458  in
                   FStar_Syntax_Syntax.mk uu____2457  in
                 uu____2454 None t.FStar_Syntax_Syntax.pos)
  
let arrow :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____2502 ->
          let uu____2506 =
            let uu____2509 =
              let uu____2510 =
                let uu____2518 = FStar_Syntax_Subst.close_binders bs  in
                let uu____2519 = FStar_Syntax_Subst.close_comp bs c  in
                (uu____2518, uu____2519)  in
              FStar_Syntax_Syntax.Tm_arrow uu____2510  in
            FStar_Syntax_Syntax.mk uu____2509  in
          uu____2506 None c.FStar_Syntax_Syntax.pos
  
let flat_arrow :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c  in
      let uu____2549 =
        let uu____2550 = FStar_Syntax_Subst.compress t  in
        uu____2550.FStar_Syntax_Syntax.n  in
      match uu____2549 with
      | FStar_Syntax_Syntax.Tm_arrow (bs1,c1) ->
          (match c1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____2570) ->
               let uu____2577 =
                 let uu____2578 = FStar_Syntax_Subst.compress tres  in
                 uu____2578.FStar_Syntax_Syntax.n  in
               (match uu____2577 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    let uu____2595 = FStar_ST.read t.FStar_Syntax_Syntax.tk
                       in
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_arrow
                         ((FStar_List.append bs1 bs'), c')) uu____2595
                      t.FStar_Syntax_Syntax.pos
                | uu____2611 -> t)
           | uu____2612 -> t)
      | uu____2613 -> t
  
let refine :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun b  ->
    fun t  ->
      let uu____2622 =
        FStar_ST.read (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.tk  in
      let uu____2627 =
        let uu____2628 = FStar_Syntax_Syntax.range_of_bv b  in
        FStar_Range.union_ranges uu____2628 t.FStar_Syntax_Syntax.pos  in
      let uu____2629 =
        let uu____2632 =
          let uu____2633 =
            let uu____2638 =
              let uu____2639 =
                let uu____2640 = FStar_Syntax_Syntax.mk_binder b  in
                [uu____2640]  in
              FStar_Syntax_Subst.close uu____2639 t  in
            (b, uu____2638)  in
          FStar_Syntax_Syntax.Tm_refine uu____2633  in
        FStar_Syntax_Syntax.mk uu____2632  in
      uu____2629 uu____2622 uu____2627
  
let branch : FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch =
  fun b  -> FStar_Syntax_Subst.close_branch b 
let rec arrow_formals_comp :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list *
      FStar_Syntax_Syntax.comp)
  =
  fun k  ->
    let k1 = FStar_Syntax_Subst.compress k  in
    match k1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____2678 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____2678 with
         | (bs1,c1) ->
             let uu____2688 = is_tot_or_gtot_comp c1  in
             if uu____2688
             then
               let uu____2694 = arrow_formals_comp (comp_result c1)  in
               (match uu____2694 with
                | (bs',k2) -> ((FStar_List.append bs1 bs'), k2))
             else (bs1, c1))
    | uu____2719 ->
        let uu____2720 = FStar_Syntax_Syntax.mk_Total k1  in ([], uu____2720)
  
let rec arrow_formals :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list *
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax)
  =
  fun k  ->
    let uu____2736 = arrow_formals_comp k  in
    match uu____2736 with | (bs,c) -> (bs, (comp_result c))
  
let abs_formals :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term *
      FStar_Syntax_Syntax.residual_comp option)
  =
  fun t  ->
    let subst_lcomp_opt s l =
      match l with
      | Some rc ->
          let uu____2783 =
            let uu___179_2784 = rc  in
            let uu____2785 =
              FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                (FStar_Syntax_Subst.subst s)
               in
            {
              FStar_Syntax_Syntax.residual_effect =
                (uu___179_2784.FStar_Syntax_Syntax.residual_effect);
              FStar_Syntax_Syntax.residual_typ = uu____2785;
              FStar_Syntax_Syntax.residual_flags =
                (uu___179_2784.FStar_Syntax_Syntax.residual_flags)
            }  in
          Some uu____2783
      | uu____2791 -> l  in
    let rec aux t1 abs_body_lcomp =
      let uu____2809 =
        let uu____2810 =
          let uu____2813 = FStar_Syntax_Subst.compress t1  in
          FStar_All.pipe_left unascribe uu____2813  in
        uu____2810.FStar_Syntax_Syntax.n  in
      match uu____2809 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t2,what) ->
          let uu____2836 = aux t2 what  in
          (match uu____2836 with
           | (bs',t3,what1) -> ((FStar_List.append bs bs'), t3, what1))
      | uu____2868 -> ([], t1, abs_body_lcomp)  in
    let uu____2875 = aux t None  in
    match uu____2875 with
    | (bs,t1,abs_body_lcomp) ->
        let uu____2898 = FStar_Syntax_Subst.open_term' bs t1  in
        (match uu____2898 with
         | (bs1,t2,opening) ->
             let abs_body_lcomp1 = subst_lcomp_opt opening abs_body_lcomp  in
             (bs1, t2, abs_body_lcomp1))
  
let mk_letbinding :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax ->
        FStar_Ident.lident ->
          (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
            FStar_Syntax_Syntax.syntax -> FStar_Syntax_Syntax.letbinding
  =
  fun lbname  ->
    fun univ_vars  ->
      fun typ  ->
        fun eff  ->
          fun def  ->
            {
              FStar_Syntax_Syntax.lbname = lbname;
              FStar_Syntax_Syntax.lbunivs = univ_vars;
              FStar_Syntax_Syntax.lbtyp = typ;
              FStar_Syntax_Syntax.lbeff = eff;
              FStar_Syntax_Syntax.lbdef = def
            }
  
let close_univs_and_mk_letbinding :
  FStar_Syntax_Syntax.fv Prims.list option ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      FStar_Ident.ident Prims.list ->
        FStar_Syntax_Syntax.term ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.letbinding
  =
  fun recs  ->
    fun lbname  ->
      fun univ_vars  ->
        fun typ  ->
          fun eff  ->
            fun def  ->
              let def1 =
                match (recs, univ_vars) with
                | (None ,uu____2973) -> def
                | (uu____2979,[]) -> def
                | (Some fvs,uu____2986) ->
                    let universes =
                      FStar_All.pipe_right univ_vars
                        (FStar_List.map
                           (fun _0_26  -> FStar_Syntax_Syntax.U_name _0_26))
                       in
                    let inst1 =
                      FStar_All.pipe_right fvs
                        (FStar_List.map
                           (fun fv  ->
                              (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v),
                                universes)))
                       in
                    FStar_Syntax_InstFV.instantiate inst1 def
                 in
              let typ1 = FStar_Syntax_Subst.close_univ_vars univ_vars typ  in
              let def2 = FStar_Syntax_Subst.close_univ_vars univ_vars def1
                 in
              mk_letbinding lbname univ_vars typ1 eff def2
  
let open_univ_vars_binders_and_comp :
  FStar_Syntax_Syntax.univ_names ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list ->
      FStar_Syntax_Syntax.comp ->
        (FStar_Syntax_Syntax.univ_names * (FStar_Syntax_Syntax.bv *
          FStar_Syntax_Syntax.aqual) Prims.list * FStar_Syntax_Syntax.comp)
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____3047 = FStar_Syntax_Subst.open_univ_vars_comp uvs c  in
            (match uu____3047 with | (uvs1,c1) -> (uvs1, [], c1))
        | uu____3063 ->
            let t' = arrow binders c  in
            let uu____3070 = FStar_Syntax_Subst.open_univ_vars uvs t'  in
            (match uu____3070 with
             | (uvs1,t'1) ->
                 let uu____3081 =
                   let uu____3082 = FStar_Syntax_Subst.compress t'1  in
                   uu____3082.FStar_Syntax_Syntax.n  in
                 (match uu____3081 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                      (uvs1, binders1, c1)
                  | uu____3108 -> failwith "Impossible"))
  
let is_tuple_constructor_string : Prims.string -> Prims.bool =
  fun s  -> FStar_Util.starts_with s "FStar.Pervasives.tuple" 
let is_dtuple_constructor_string : Prims.string -> Prims.bool =
  fun s  ->
    (s = "Prims.dtuple2") ||
      (FStar_Util.starts_with s "FStar.Pervasives.dtuple")
  
let is_tuple_datacon_string : Prims.string -> Prims.bool =
  fun s  -> FStar_Util.starts_with s "FStar.Pervasives.Mktuple" 
let is_dtuple_datacon_string : Prims.string -> Prims.bool =
  fun s  ->
    (s = "Prims.Mkdtuple2") ||
      (FStar_Util.starts_with s "FStar.Pervasives.Mkdtuple")
  
let mod_prefix_dtuple : Prims.int -> Prims.string -> FStar_Ident.lident =
  fun n1  ->
    if n1 = (Prims.parse_int "2")
    then FStar_Syntax_Const.pconst
    else FStar_Syntax_Const.psconst
  
let is_tuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_tuple_constructor_string
          ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str
    | uu____3145 -> false
  
let mk_tuple_lid : Prims.int -> FStar_Range.range -> FStar_Ident.lident =
  fun n1  ->
    fun r  ->
      let t =
        let uu____3153 = FStar_Util.string_of_int n1  in
        FStar_Util.format1 "tuple%s" uu____3153  in
      let uu____3154 = FStar_Syntax_Const.psconst t  in
      FStar_Ident.set_lid_range uu____3154 r
  
let mk_tuple_data_lid : Prims.int -> FStar_Range.range -> FStar_Ident.lident
  =
  fun n1  ->
    fun r  ->
      let t =
        let uu____3162 = FStar_Util.string_of_int n1  in
        FStar_Util.format1 "Mktuple%s" uu____3162  in
      let uu____3163 = FStar_Syntax_Const.psconst t  in
      FStar_Ident.set_lid_range uu____3163 r
  
let is_tuple_data_lid : FStar_Ident.lident -> Prims.int -> Prims.bool =
  fun f  ->
    fun n1  ->
      let uu____3170 = mk_tuple_data_lid n1 FStar_Range.dummyRange  in
      FStar_Ident.lid_equals f uu____3170
  
let is_tuple_data_lid' : FStar_Ident.lident -> Prims.bool =
  fun f  -> is_tuple_datacon_string f.FStar_Ident.str 
let is_tuple_constructor_lid : FStar_Ident.ident -> Prims.bool =
  fun lid  -> is_tuple_constructor_string (FStar_Ident.text_of_id lid) 
let is_dtuple_constructor_lid : FStar_Ident.lident -> Prims.bool =
  fun lid  -> is_dtuple_constructor_string lid.FStar_Ident.str 
let is_dtuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____3188 -> false
  
let mk_dtuple_lid : Prims.int -> FStar_Range.range -> FStar_Ident.lident =
  fun n1  ->
    fun r  ->
      let t =
        let uu____3196 = FStar_Util.string_of_int n1  in
        FStar_Util.format1 "dtuple%s" uu____3196  in
      let uu____3197 = let uu____3198 = mod_prefix_dtuple n1  in uu____3198 t
         in
      FStar_Ident.set_lid_range uu____3197 r
  
let mk_dtuple_data_lid : Prims.int -> FStar_Range.range -> FStar_Ident.lident
  =
  fun n1  ->
    fun r  ->
      let t =
        let uu____3208 = FStar_Util.string_of_int n1  in
        FStar_Util.format1 "Mkdtuple%s" uu____3208  in
      let uu____3209 = let uu____3210 = mod_prefix_dtuple n1  in uu____3210 t
         in
      FStar_Ident.set_lid_range uu____3209 r
  
let is_dtuple_data_lid' : FStar_Ident.lident -> Prims.bool =
  fun f  -> is_dtuple_datacon_string (FStar_Ident.text_of_lid f) 
let is_lid_equality : FStar_Ident.lident -> Prims.bool =
  fun x  -> FStar_Ident.lid_equals x FStar_Syntax_Const.eq2_lid 
let is_forall : FStar_Ident.lident -> Prims.bool =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Syntax_Const.forall_lid 
let is_exists : FStar_Ident.lident -> Prims.bool =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Syntax_Const.exists_lid 
let is_qlid : FStar_Ident.lident -> Prims.bool =
  fun lid  -> (is_forall lid) || (is_exists lid) 
let is_equality x = is_lid_equality x.FStar_Syntax_Syntax.v 
let lid_is_connective : FStar_Ident.lident -> Prims.bool =
  let lst =
    [FStar_Syntax_Const.and_lid;
    FStar_Syntax_Const.or_lid;
    FStar_Syntax_Const.not_lid;
    FStar_Syntax_Const.iff_lid;
    FStar_Syntax_Const.imp_lid]  in
  fun lid  -> FStar_Util.for_some (FStar_Ident.lid_equals lid) lst 
let is_constructor :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool =
  fun t  ->
    fun lid  ->
      let uu____3250 =
        let uu____3251 = pre_typ t  in uu____3251.FStar_Syntax_Syntax.n  in
      match uu____3250 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____3259 -> false
  
let rec is_constructed_typ :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool =
  fun t  ->
    fun lid  ->
      let uu____3266 =
        let uu____3267 = pre_typ t  in uu____3267.FStar_Syntax_Syntax.n  in
      match uu____3266 with
      | FStar_Syntax_Syntax.Tm_fvar uu____3270 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t1,uu____3272) ->
          is_constructed_typ t1 lid
      | uu____3287 -> false
  
let rec get_tycon :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term option =
  fun t  ->
    let t1 = pre_typ t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar uu____3294 -> Some t1
    | FStar_Syntax_Syntax.Tm_name uu____3295 -> Some t1
    | FStar_Syntax_Syntax.Tm_fvar uu____3296 -> Some t1
    | FStar_Syntax_Syntax.Tm_app (t2,uu____3298) -> get_tycon t2
    | uu____3313 -> None
  
let is_interpreted : FStar_Ident.lident -> Prims.bool =
  fun l  ->
    let theory_syms =
      [FStar_Syntax_Const.op_Eq;
      FStar_Syntax_Const.op_notEq;
      FStar_Syntax_Const.op_LT;
      FStar_Syntax_Const.op_LTE;
      FStar_Syntax_Const.op_GT;
      FStar_Syntax_Const.op_GTE;
      FStar_Syntax_Const.op_Subtraction;
      FStar_Syntax_Const.op_Minus;
      FStar_Syntax_Const.op_Addition;
      FStar_Syntax_Const.op_Multiply;
      FStar_Syntax_Const.op_Division;
      FStar_Syntax_Const.op_Modulus;
      FStar_Syntax_Const.op_And;
      FStar_Syntax_Const.op_Or;
      FStar_Syntax_Const.op_Negation]  in
    FStar_Util.for_some (FStar_Ident.lid_equals l) theory_syms
  
let is_fstar_tactics_embed : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____3322 =
      let uu____3323 = un_uinst t  in uu____3323.FStar_Syntax_Syntax.n  in
    match uu____3322 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv
          FStar_Syntax_Const.fstar_refl_embed_lid
    | uu____3327 -> false
  
let is_fstar_tactics_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____3331 =
      let uu____3332 = un_uinst t  in uu____3332.FStar_Syntax_Syntax.n  in
    match uu____3331 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.by_tactic_lid
    | uu____3336 -> false
  
let ktype :
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax
  =
  (FStar_Syntax_Syntax.mk
     (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)) None
    FStar_Range.dummyRange
  
let ktype0 :
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax
  =
  (FStar_Syntax_Syntax.mk
     (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)) None
    FStar_Range.dummyRange
  
let type_u :
  Prims.unit ->
    ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.universe)
  =
  fun uu____3361  ->
    let u =
      let uu____3365 = FStar_Syntax_Unionfind.univ_fresh ()  in
      FStar_All.pipe_left (fun _0_27  -> FStar_Syntax_Syntax.U_unif _0_27)
        uu____3365
       in
    let uu____3370 =
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u) None
        FStar_Range.dummyRange
       in
    (uu____3370, u)
  
let kt_kt : FStar_Syntax_Syntax.term =
  FStar_Syntax_Const.kunary ktype0 ktype0 
let kt_kt_kt : FStar_Syntax_Syntax.term =
  FStar_Syntax_Const.kbin ktype0 ktype0 ktype0 
let fvar_const : FStar_Ident.lident -> FStar_Syntax_Syntax.term =
  fun l  ->
    FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant None
  
let tand : FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.and_lid 
let tor : FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.or_lid 
let timp : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.imp_lid
    (FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")) None
  
let tiff : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.iff_lid
    (FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "2")) None
  
let t_bool : FStar_Syntax_Syntax.term =
  fvar_const FStar_Syntax_Const.bool_lid 
let t_false : FStar_Syntax_Syntax.term =
  fvar_const FStar_Syntax_Const.false_lid 
let t_true : FStar_Syntax_Syntax.term =
  fvar_const FStar_Syntax_Const.true_lid 
let b2t_v : FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.b2t_lid 
let t_not : FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.not_lid 
let mk_conj_opt :
  FStar_Syntax_Syntax.term option ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax option
  =
  fun phi1  ->
    fun phi2  ->
      match phi1 with
      | None  -> Some phi2
      | Some phi11 ->
          let uu____3393 =
            let uu____3396 =
              FStar_Range.union_ranges phi11.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos
               in
            let uu____3397 =
              let uu____3400 =
                let uu____3401 =
                  let uu____3411 =
                    let uu____3413 = FStar_Syntax_Syntax.as_arg phi11  in
                    let uu____3414 =
                      let uu____3416 = FStar_Syntax_Syntax.as_arg phi2  in
                      [uu____3416]  in
                    uu____3413 :: uu____3414  in
                  (tand, uu____3411)  in
                FStar_Syntax_Syntax.Tm_app uu____3401  in
              FStar_Syntax_Syntax.mk uu____3400  in
            uu____3397 None uu____3396  in
          Some uu____3393
  
let mk_binop op_t phi1 phi2 =
  let uu____3451 =
    FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
      phi2.FStar_Syntax_Syntax.pos
     in
  let uu____3452 =
    let uu____3455 =
      let uu____3456 =
        let uu____3466 =
          let uu____3468 = FStar_Syntax_Syntax.as_arg phi1  in
          let uu____3469 =
            let uu____3471 = FStar_Syntax_Syntax.as_arg phi2  in [uu____3471]
             in
          uu____3468 :: uu____3469  in
        (op_t, uu____3466)  in
      FStar_Syntax_Syntax.Tm_app uu____3456  in
    FStar_Syntax_Syntax.mk uu____3455  in
  uu____3452 None uu____3451 
let mk_neg phi =
  let uu____3492 =
    let uu____3495 =
      let uu____3496 =
        let uu____3506 =
          let uu____3508 = FStar_Syntax_Syntax.as_arg phi  in [uu____3508]
           in
        (t_not, uu____3506)  in
      FStar_Syntax_Syntax.Tm_app uu____3496  in
    FStar_Syntax_Syntax.mk uu____3495  in
  uu____3492 None phi.FStar_Syntax_Syntax.pos 
let mk_conj phi1 phi2 = mk_binop tand phi1 phi2 
let mk_conj_l :
  FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term =
  fun phi  ->
    match phi with
    | [] ->
        FStar_Syntax_Syntax.fvar FStar_Syntax_Const.true_lid
          FStar_Syntax_Syntax.Delta_constant None
    | hd1::tl1 -> FStar_List.fold_right mk_conj tl1 hd1
  
let mk_disj phi1 phi2 = mk_binop tor phi1 phi2 
let mk_disj_l :
  FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term =
  fun phi  ->
    match phi with
    | [] -> t_false
    | hd1::tl1 -> FStar_List.fold_right mk_disj tl1 hd1
  
let mk_imp :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  = fun phi1  -> fun phi2  -> mk_binop timp phi1 phi2 
let mk_iff :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  = fun phi1  -> fun phi2  -> mk_binop tiff phi1 phi2 
let b2t e =
  let uu____3583 =
    let uu____3586 =
      let uu____3587 =
        let uu____3597 =
          let uu____3599 = FStar_Syntax_Syntax.as_arg e  in [uu____3599]  in
        (b2t_v, uu____3597)  in
      FStar_Syntax_Syntax.Tm_app uu____3587  in
    FStar_Syntax_Syntax.mk uu____3586  in
  uu____3583 None e.FStar_Syntax_Syntax.pos 
let teq : FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.eq2_lid 
let mk_untyped_eq2 e1 e2 =
  let uu____3623 =
    FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
      e2.FStar_Syntax_Syntax.pos
     in
  let uu____3624 =
    let uu____3627 =
      let uu____3628 =
        let uu____3638 =
          let uu____3640 = FStar_Syntax_Syntax.as_arg e1  in
          let uu____3641 =
            let uu____3643 = FStar_Syntax_Syntax.as_arg e2  in [uu____3643]
             in
          uu____3640 :: uu____3641  in
        (teq, uu____3638)  in
      FStar_Syntax_Syntax.Tm_app uu____3628  in
    FStar_Syntax_Syntax.mk uu____3627  in
  uu____3624 None uu____3623 
let mk_eq2 :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term ->
          (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
            FStar_Syntax_Syntax.syntax
  =
  fun u  ->
    fun t  ->
      fun e1  ->
        fun e2  ->
          let eq_inst = FStar_Syntax_Syntax.mk_Tm_uinst teq [u]  in
          let uu____3666 =
            FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
              e2.FStar_Syntax_Syntax.pos
             in
          let uu____3667 =
            let uu____3670 =
              let uu____3671 =
                let uu____3681 =
                  let uu____3683 = FStar_Syntax_Syntax.iarg t  in
                  let uu____3684 =
                    let uu____3686 = FStar_Syntax_Syntax.as_arg e1  in
                    let uu____3687 =
                      let uu____3689 = FStar_Syntax_Syntax.as_arg e2  in
                      [uu____3689]  in
                    uu____3686 :: uu____3687  in
                  uu____3683 :: uu____3684  in
                (eq_inst, uu____3681)  in
              FStar_Syntax_Syntax.Tm_app uu____3671  in
            FStar_Syntax_Syntax.mk uu____3670  in
          uu____3667 None uu____3666
  
let mk_has_type t x t' =
  let t_has_type = fvar_const FStar_Syntax_Const.has_type_lid  in
  let t_has_type1 =
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_uinst
         (t_has_type,
           [FStar_Syntax_Syntax.U_zero; FStar_Syntax_Syntax.U_zero])) None
      FStar_Range.dummyRange
     in
  let uu____3727 =
    let uu____3730 =
      let uu____3731 =
        let uu____3741 =
          let uu____3743 = FStar_Syntax_Syntax.iarg t  in
          let uu____3744 =
            let uu____3746 = FStar_Syntax_Syntax.as_arg x  in
            let uu____3747 =
              let uu____3749 = FStar_Syntax_Syntax.as_arg t'  in [uu____3749]
               in
            uu____3746 :: uu____3747  in
          uu____3743 :: uu____3744  in
        (t_has_type1, uu____3741)  in
      FStar_Syntax_Syntax.Tm_app uu____3731  in
    FStar_Syntax_Syntax.mk uu____3730  in
  uu____3727 None FStar_Range.dummyRange 
let lex_t : FStar_Syntax_Syntax.term =
  fvar_const FStar_Syntax_Const.lex_t_lid 
let lex_top : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lextop_lid
    FStar_Syntax_Syntax.Delta_constant (Some FStar_Syntax_Syntax.Data_ctor)
  
let lex_pair : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lexcons_lid
    FStar_Syntax_Syntax.Delta_constant (Some FStar_Syntax_Syntax.Data_ctor)
  
let tforall : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.forall_lid
    (FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")) None
  
let t_haseq : FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.haseq_lid
    FStar_Syntax_Syntax.Delta_constant None
  
let lcomp_of_comp :
  (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.lcomp
  =
  fun c0  ->
    let uu____3768 =
      match c0.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____3775 ->
          (FStar_Syntax_Const.effect_Tot_lid, [FStar_Syntax_Syntax.TOTAL])
      | FStar_Syntax_Syntax.GTotal uu____3782 ->
          (FStar_Syntax_Const.effect_GTot_lid,
            [FStar_Syntax_Syntax.SOMETRIVIAL])
      | FStar_Syntax_Syntax.Comp c ->
          ((c.FStar_Syntax_Syntax.effect_name),
            (c.FStar_Syntax_Syntax.flags))
       in
    match uu____3768 with
    | (eff_name,flags) ->
        {
          FStar_Syntax_Syntax.eff_name = eff_name;
          FStar_Syntax_Syntax.res_typ = (comp_result c0);
          FStar_Syntax_Syntax.cflags = flags;
          FStar_Syntax_Syntax.comp = ((fun uu____3795  -> c0))
        }
  
let mk_residual_comp :
  FStar_Ident.lident ->
    (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax option ->
      FStar_Syntax_Syntax.cflags Prims.list ->
        FStar_Syntax_Syntax.residual_comp
  =
  fun l  ->
    fun t  ->
      fun f  ->
        {
          FStar_Syntax_Syntax.residual_effect = l;
          FStar_Syntax_Syntax.residual_typ = t;
          FStar_Syntax_Syntax.residual_flags = f
        }
  
let residual_tot :
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax -> FStar_Syntax_Syntax.residual_comp
  =
  fun t  ->
    {
      FStar_Syntax_Syntax.residual_effect = FStar_Syntax_Const.effect_Tot_lid;
      FStar_Syntax_Syntax.residual_typ = (Some t);
      FStar_Syntax_Syntax.residual_flags = [FStar_Syntax_Syntax.TOTAL]
    }
  
let residual_comp_of_comp :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.residual_comp =
  fun c  ->
    {
      FStar_Syntax_Syntax.residual_effect = (comp_effect_name c);
      FStar_Syntax_Syntax.residual_typ = (Some (comp_result c));
      FStar_Syntax_Syntax.residual_flags = (comp_flags c)
    }
  
let residual_comp_of_lcomp :
  FStar_Syntax_Syntax.lcomp -> FStar_Syntax_Syntax.residual_comp =
  fun lc  ->
    {
      FStar_Syntax_Syntax.residual_effect = (lc.FStar_Syntax_Syntax.eff_name);
      FStar_Syntax_Syntax.residual_typ =
        (Some (lc.FStar_Syntax_Syntax.res_typ));
      FStar_Syntax_Syntax.residual_flags = (lc.FStar_Syntax_Syntax.cflags)
    }
  
let mk_forall_aux fa x body =
  let uu____3855 =
    let uu____3858 =
      let uu____3859 =
        let uu____3869 =
          let uu____3871 =
            FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort  in
          let uu____3872 =
            let uu____3874 =
              let uu____3875 =
                let uu____3876 =
                  let uu____3877 = FStar_Syntax_Syntax.mk_binder x  in
                  [uu____3877]  in
                abs uu____3876 body (Some (residual_tot ktype0))  in
              FStar_Syntax_Syntax.as_arg uu____3875  in
            [uu____3874]  in
          uu____3871 :: uu____3872  in
        (fa, uu____3869)  in
      FStar_Syntax_Syntax.Tm_app uu____3859  in
    FStar_Syntax_Syntax.mk uu____3858  in
  uu____3855 None FStar_Range.dummyRange 
let mk_forall_no_univ :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.typ ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  = fun x  -> fun body  -> mk_forall_aux tforall x body 
let mk_forall :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.typ ->
        (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
          FStar_Syntax_Syntax.syntax
  =
  fun u  ->
    fun x  ->
      fun body  ->
        let tforall1 = FStar_Syntax_Syntax.mk_Tm_uinst tforall [u]  in
        mk_forall_aux tforall1 x body
  
let close_forall_no_univs :
  FStar_Syntax_Syntax.binder Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f1  ->
             let uu____3915 = FStar_Syntax_Syntax.is_null_binder b  in
             if uu____3915 then f1 else mk_forall_no_univ (fst b) f1) bs f
  
let rec is_wild_pat p =
  match p.FStar_Syntax_Syntax.v with
  | FStar_Syntax_Syntax.Pat_wild uu____3928 -> true
  | uu____3929 -> false 
let if_then_else b t1 t2 =
  let then_branch =
    let uu____3972 =
      FStar_Syntax_Syntax.withinfo
        (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
        FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n
        t1.FStar_Syntax_Syntax.pos
       in
    (uu____3972, None, t1)  in
  let else_branch =
    let uu____3995 =
      FStar_Syntax_Syntax.withinfo
        (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool false))
        FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n
        t2.FStar_Syntax_Syntax.pos
       in
    (uu____3995, None, t2)  in
  let uu____4007 =
    let uu____4008 =
      FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
        t2.FStar_Syntax_Syntax.pos
       in
    FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____4008  in
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch])) None
    uu____4007
  
let mk_squash p =
  let sq =
    FStar_Syntax_Syntax.fvar FStar_Syntax_Const.squash_lid
      (FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")) None
     in
  let uu____4066 =
    FStar_Syntax_Syntax.mk_Tm_uinst sq [FStar_Syntax_Syntax.U_zero]  in
  let uu____4069 =
    let uu____4075 = FStar_Syntax_Syntax.as_arg p  in [uu____4075]  in
  mk_app uu____4066 uu____4069 
let un_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax option
  =
  fun t  ->
    let uu____4082 = head_and_args t  in
    match uu____4082 with
    | (head1,args) ->
        let uu____4111 =
          let uu____4119 =
            let uu____4120 = un_uinst head1  in
            uu____4120.FStar_Syntax_Syntax.n  in
          (uu____4119, args)  in
        (match uu____4111 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(p,uu____4133)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid
             -> Some p
         | (FStar_Syntax_Syntax.Tm_refine (b,p),[]) ->
             (match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_fvar fv when
                  FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Syntax_Const.unit_lid
                  ->
                  let uu____4172 =
                    let uu____4175 =
                      let uu____4176 = FStar_Syntax_Syntax.mk_binder b  in
                      [uu____4176]  in
                    FStar_Syntax_Subst.open_term uu____4175 p  in
                  (match uu____4172 with
                   | (bs,p1) ->
                       let b1 =
                         match bs with
                         | b1::[] -> b1
                         | uu____4194 -> failwith "impossible"  in
                       let uu____4197 =
                         let uu____4198 = FStar_Syntax_Free.names p1  in
                         FStar_Util.set_mem (fst b1) uu____4198  in
                       if uu____4197 then None else Some p1)
              | uu____4206 -> None)
         | uu____4209 -> None)
  
let arrow_one :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder * FStar_Syntax_Syntax.comp) option
  =
  fun t  ->
    let uu____4228 =
      let uu____4229 = FStar_Syntax_Subst.compress t  in
      uu____4229.FStar_Syntax_Syntax.n  in
    match uu____4228 with
    | FStar_Syntax_Syntax.Tm_arrow ([],c) ->
        failwith "fatal: empty binders on arrow?"
    | FStar_Syntax_Syntax.Tm_arrow (b::[],c) -> Some (b, c)
    | FStar_Syntax_Syntax.Tm_arrow (b::bs,c) ->
        let uu____4290 =
          let uu____4295 =
            let uu____4296 = arrow bs c  in
            FStar_Syntax_Syntax.mk_Total uu____4296  in
          (b, uu____4295)  in
        Some uu____4290
    | uu____4303 -> None
  
let is_free_in :
  FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.term -> Prims.bool =
  fun bv  ->
    fun t  ->
      let uu____4312 = FStar_Syntax_Free.names t  in
      FStar_Util.set_mem bv uu____4312
  
type qpats = FStar_Syntax_Syntax.args Prims.list
type connective =
  | QAll of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) 
  | QEx of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) 
  | BaseConn of (FStar_Ident.lident * FStar_Syntax_Syntax.args) 
let uu___is_QAll : connective -> Prims.bool =
  fun projectee  ->
    match projectee with | QAll _0 -> true | uu____4342 -> false
  
let __proj__QAll__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ)
  = fun projectee  -> match projectee with | QAll _0 -> _0 
let uu___is_QEx : connective -> Prims.bool =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____4366 -> false
  
let __proj__QEx__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ)
  = fun projectee  -> match projectee with | QEx _0 -> _0 
let uu___is_BaseConn : connective -> Prims.bool =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____4389 -> false
  
let __proj__BaseConn__item___0 :
  connective -> (FStar_Ident.lident * FStar_Syntax_Syntax.args) =
  fun projectee  -> match projectee with | BaseConn _0 -> _0 
let destruct_typ_as_formula : FStar_Syntax_Syntax.term -> connective option =
  fun f  ->
    let rec unmeta_monadic f1 =
      let f2 = FStar_Syntax_Subst.compress f1  in
      match f2.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic uu____4414) -> unmeta_monadic t
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic_lift uu____4424) ->
          unmeta_monadic t
      | uu____4434 -> f2  in
    let destruct_base_conn f1 =
      let connectives =
        [(FStar_Syntax_Const.true_lid, (Prims.parse_int "0"));
        (FStar_Syntax_Const.false_lid, (Prims.parse_int "0"));
        (FStar_Syntax_Const.and_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.or_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.imp_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.iff_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.ite_lid, (Prims.parse_int "3"));
        (FStar_Syntax_Const.not_lid, (Prims.parse_int "1"));
        (FStar_Syntax_Const.eq2_lid, (Prims.parse_int "3"));
        (FStar_Syntax_Const.eq2_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.eq3_lid, (Prims.parse_int "4"));
        (FStar_Syntax_Const.eq3_lid, (Prims.parse_int "2"))]  in
      let aux f2 uu____4479 =
        match uu____4479 with
        | (lid,arity) ->
            let uu____4485 =
              let uu____4495 = unmeta_monadic f2  in head_and_args uu____4495
               in
            (match uu____4485 with
             | (t,args) ->
                 let t1 = un_uinst t  in
                 let uu____4514 =
                   (is_constructor t1 lid) &&
                     ((FStar_List.length args) = arity)
                    in
                 if uu____4514 then Some (BaseConn (lid, args)) else None)
         in
      FStar_Util.find_map connectives (aux f1)  in
    let patterns t =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t2,FStar_Syntax_Syntax.Meta_pattern pats) ->
          let uu____4565 = FStar_Syntax_Subst.compress t2  in
          (pats, uu____4565)
      | uu____4572 ->
          let uu____4573 = FStar_Syntax_Subst.compress t1  in
          ([], uu____4573)
       in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
         in
      let flat t1 =
        let uu____4615 = head_and_args t1  in
        match uu____4615 with
        | (t2,args) ->
            let uu____4646 = un_uinst t2  in
            let uu____4647 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____4663  ->
                      match uu____4663 with
                      | (t3,imp) ->
                          let uu____4670 = unascribe t3  in (uu____4670, imp)))
               in
            (uu____4646, uu____4647)
         in
      let rec aux qopt out t1 =
        let uu____4693 = let uu____4702 = flat t1  in (qopt, uu____4702)  in
        match uu____4693 with
        | (Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.tk = uu____4717;
                 FStar_Syntax_Syntax.pos = uu____4718;
                 FStar_Syntax_Syntax.vars = uu____4719;_},({
                                                             FStar_Syntax_Syntax.n
                                                               =
                                                               FStar_Syntax_Syntax.Tm_abs
                                                               (b::[],t2,uu____4722);
                                                             FStar_Syntax_Syntax.tk
                                                               = uu____4723;
                                                             FStar_Syntax_Syntax.pos
                                                               = uu____4724;
                                                             FStar_Syntax_Syntax.vars
                                                               = uu____4725;_},uu____4726)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.tk = uu____4777;
                 FStar_Syntax_Syntax.pos = uu____4778;
                 FStar_Syntax_Syntax.vars = uu____4779;_},uu____4780::
               ({
                  FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                    (b::[],t2,uu____4783);
                  FStar_Syntax_Syntax.tk = uu____4784;
                  FStar_Syntax_Syntax.pos = uu____4785;
                  FStar_Syntax_Syntax.vars = uu____4786;_},uu____4787)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.tk = uu____4845;
               FStar_Syntax_Syntax.pos = uu____4846;
               FStar_Syntax_Syntax.vars = uu____4847;_},({
                                                           FStar_Syntax_Syntax.n
                                                             =
                                                             FStar_Syntax_Syntax.Tm_abs
                                                             (b::[],t2,uu____4850);
                                                           FStar_Syntax_Syntax.tk
                                                             = uu____4851;
                                                           FStar_Syntax_Syntax.pos
                                                             = uu____4852;
                                                           FStar_Syntax_Syntax.vars
                                                             = uu____4853;_},uu____4854)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            aux
              (Some
                 (is_forall
                    (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v))
              (b :: out) t2
        | (None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.tk = uu____4912;
               FStar_Syntax_Syntax.pos = uu____4913;
               FStar_Syntax_Syntax.vars = uu____4914;_},uu____4915::({
                                                                    FStar_Syntax_Syntax.n
                                                                    =
                                                                    FStar_Syntax_Syntax.Tm_abs
                                                                    (b::[],t2,uu____4918);
                                                                    FStar_Syntax_Syntax.tk
                                                                    =
                                                                    uu____4919;
                                                                    FStar_Syntax_Syntax.pos
                                                                    =
                                                                    uu____4920;
                                                                    FStar_Syntax_Syntax.vars
                                                                    =
                                                                    uu____4921;_},uu____4922)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            aux
              (Some
                 (is_forall
                    (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v))
              (b :: out) t2
        | (Some b,uu____4988) ->
            let bs = FStar_List.rev out  in
            let uu____5006 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____5006 with
             | (bs1,t2) ->
                 let uu____5012 = patterns t2  in
                 (match uu____5012 with
                  | (pats,body) ->
                      if b
                      then Some (QAll (bs1, pats, body))
                      else Some (QEx (bs1, pats, body))))
        | uu____5050 -> None  in
      aux None [] t  in
    let u_connectives =
      [(FStar_Syntax_Const.true_lid, FStar_Syntax_Const.c_true_lid,
         (Prims.parse_int "0"));
      (FStar_Syntax_Const.false_lid, FStar_Syntax_Const.c_false_lid,
        (Prims.parse_int "0"));
      (FStar_Syntax_Const.and_lid, FStar_Syntax_Const.c_and_lid,
        (Prims.parse_int "2"));
      (FStar_Syntax_Const.or_lid, FStar_Syntax_Const.c_or_lid,
        (Prims.parse_int "2"))]
       in
    let destruct_sq_base_conn t =
      let uu____5086 = un_squash t  in
      FStar_Util.bind_opt uu____5086
        (fun t1  ->
           let uu____5095 = head_and_args' t1  in
           match uu____5095 with
           | (hd1,args) ->
               let uu____5116 =
                 let uu____5119 =
                   let uu____5120 = un_uinst hd1  in
                   uu____5120.FStar_Syntax_Syntax.n  in
                 (uu____5119, (FStar_List.length args))  in
               (match uu____5116 with
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_28) when
                    (_0_28 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_and_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.and_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_29) when
                    (_0_29 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_or_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.or_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_30) when
                    (_0_30 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_eq2_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_31) when
                    (_0_31 = (Prims.parse_int "3")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_eq2_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_32) when
                    (_0_32 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_eq3_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_33) when
                    (_0_33 = (Prims.parse_int "4")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_eq3_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_34) when
                    (_0_34 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_true_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.true_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_35) when
                    (_0_35 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Syntax_Const.c_false_lid)
                    -> Some (BaseConn (FStar_Syntax_Const.false_lid, args))
                | uu____5178 -> None))
       in
    let rec destruct_sq_forall t =
      let uu____5195 = un_squash t  in
      FStar_Util.bind_opt uu____5195
        (fun t1  ->
           let uu____5204 = arrow_one t1  in
           match uu____5204 with
           | Some (b,c) ->
               let uu____5213 =
                 let uu____5214 = is_tot_or_gtot_comp c  in
                 Prims.op_Negation uu____5214  in
               if uu____5213
               then None
               else
                 (let q =
                    let uu____5220 = comp_to_comp_typ c  in
                    uu____5220.FStar_Syntax_Syntax.result_typ  in
                  let uu____5221 = FStar_Syntax_Subst.open_term [b] q  in
                  match uu____5221 with
                  | (bs,q1) ->
                      let b1 =
                        match bs with
                        | b1::[] -> b1
                        | uu____5239 -> failwith "impossible"  in
                      let uu____5242 = is_free_in (fst b1) q1  in
                      if uu____5242
                      then
                        let uu____5244 = patterns q1  in
                        (match uu____5244 with
                         | (pats,q2) ->
                             FStar_All.pipe_left maybe_collect
                               (Some (QAll ([b1], pats, q2))))
                      else
                        (let uu____5284 =
                           let uu____5285 =
                             let uu____5288 =
                               let uu____5290 =
                                 FStar_Syntax_Syntax.as_arg
                                   (fst b1).FStar_Syntax_Syntax.sort
                                  in
                               let uu____5291 =
                                 let uu____5293 =
                                   FStar_Syntax_Syntax.as_arg q1  in
                                 [uu____5293]  in
                               uu____5290 :: uu____5291  in
                             (FStar_Syntax_Const.imp_lid, uu____5288)  in
                           BaseConn uu____5285  in
                         Some uu____5284))
           | uu____5295 -> None)
    
    and destruct_sq_exists t =
      let uu____5300 = un_squash t  in
      FStar_Util.bind_opt uu____5300
        (fun t1  ->
           let uu____5309 = head_and_args' t1  in
           match uu____5309 with
           | (hd1,args) ->
               let uu____5330 =
                 let uu____5338 =
                   let uu____5339 = un_uinst hd1  in
                   uu____5339.FStar_Syntax_Syntax.n  in
                 (uu____5338, args)  in
               (match uu____5330 with
                | (FStar_Syntax_Syntax.Tm_fvar
                   fv,(a1,uu____5350)::(a2,uu____5352)::[]) when
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Syntax_Const.dtuple2_lid
                    ->
                    let uu____5378 =
                      let uu____5379 = FStar_Syntax_Subst.compress a2  in
                      uu____5379.FStar_Syntax_Syntax.n  in
                    (match uu____5378 with
                     | FStar_Syntax_Syntax.Tm_abs (b::[],q,uu____5385) ->
                         let uu____5401 = FStar_Syntax_Subst.open_term [b] q
                            in
                         (match uu____5401 with
                          | (bs,q1) ->
                              let b1 =
                                match bs with
                                | b1::[] -> b1
                                | uu____5423 -> failwith "impossible"  in
                              let uu____5426 = patterns q1  in
                              (match uu____5426 with
                               | (pats,q2) ->
                                   FStar_All.pipe_left maybe_collect
                                     (Some (QEx ([b1], pats, q2)))))
                     | uu____5465 -> None)
                | uu____5466 -> None))
    
    and maybe_collect f1 =
      match f1 with
      | Some (QAll (bs,pats,phi)) ->
          let uu____5480 = destruct_sq_forall phi  in
          (match uu____5480 with
           | Some (QAll (bs',pats',psi)) ->
               FStar_All.pipe_left (fun _0_36  -> Some _0_36)
                 (QAll
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____5493 -> f1)
      | Some (QEx (bs,pats,phi)) ->
          let uu____5498 = destruct_sq_exists phi  in
          (match uu____5498 with
           | Some (QEx (bs',pats',psi)) ->
               FStar_All.pipe_left (fun _0_37  -> Some _0_37)
                 (QEx
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____5511 -> f1)
      | uu____5513 -> f1
     in
    let phi = unmeta_monadic f  in
    let uu____5516 = destruct_base_conn phi  in
    FStar_Util.catch_opt uu____5516
      (fun uu____5518  ->
         let uu____5519 = destruct_q_conn phi  in
         FStar_Util.catch_opt uu____5519
           (fun uu____5521  ->
              let uu____5522 = destruct_sq_base_conn phi  in
              FStar_Util.catch_opt uu____5522
                (fun uu____5524  ->
                   let uu____5525 = destruct_sq_forall phi  in
                   FStar_Util.catch_opt uu____5525
                     (fun uu____5527  ->
                        let uu____5528 = destruct_sq_exists phi  in
                        FStar_Util.catch_opt uu____5528
                          (fun uu____5530  -> None)))))
  
let action_as_lb :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action -> FStar_Syntax_Syntax.sigelt
  =
  fun eff_lid  ->
    fun a  ->
      let lb =
        let uu____5538 =
          let uu____5541 =
            FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
              FStar_Syntax_Syntax.Delta_equational None
             in
          FStar_Util.Inr uu____5541  in
        let uu____5542 =
          let uu____5543 =
            FStar_Syntax_Syntax.mk_Total a.FStar_Syntax_Syntax.action_typ  in
          arrow a.FStar_Syntax_Syntax.action_params uu____5543  in
        let uu____5546 =
          abs a.FStar_Syntax_Syntax.action_params
            a.FStar_Syntax_Syntax.action_defn None
           in
        close_univs_and_mk_letbinding None uu____5538
          a.FStar_Syntax_Syntax.action_univs uu____5542
          FStar_Syntax_Const.effect_Tot_lid uu____5546
         in
      {
        FStar_Syntax_Syntax.sigel =
          (FStar_Syntax_Syntax.Sig_let
             ((false, [lb]), [a.FStar_Syntax_Syntax.action_name], []));
        FStar_Syntax_Syntax.sigrng =
          ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.sigquals =
          [FStar_Syntax_Syntax.Visible_default;
          FStar_Syntax_Syntax.Action eff_lid];
        FStar_Syntax_Syntax.sigmeta = FStar_Syntax_Syntax.default_sigmeta
      }
  
let mk_reify t =
  let reify_ =
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_reify) None
      t.FStar_Syntax_Syntax.pos
     in
  let uu____5574 =
    let uu____5577 =
      let uu____5578 =
        let uu____5588 =
          let uu____5590 = FStar_Syntax_Syntax.as_arg t  in [uu____5590]  in
        (reify_, uu____5588)  in
      FStar_Syntax_Syntax.Tm_app uu____5578  in
    FStar_Syntax_Syntax.mk uu____5577  in
  uu____5574 None t.FStar_Syntax_Syntax.pos 
let rec delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____5606 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar uu____5622 ->
        FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_name uu____5623 ->
        FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_match uu____5624 ->
        FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_uvar uu____5640 ->
        FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_unknown  -> FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_type uu____5649 ->
        FStar_Syntax_Syntax.Delta_constant
    | FStar_Syntax_Syntax.Tm_constant uu____5650 ->
        FStar_Syntax_Syntax.Delta_constant
    | FStar_Syntax_Syntax.Tm_arrow uu____5651 ->
        FStar_Syntax_Syntax.Delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____5660) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____5665;
           FStar_Syntax_Syntax.index = uu____5666;
           FStar_Syntax_Syntax.sort = t2;_},uu____5668)
        -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_meta (t2,uu____5676) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____5682,uu____5683) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_app (t2,uu____5713) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_abs (uu____5728,t2,uu____5730) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_let (uu____5743,t2) -> delta_qualifier t2
  
let rec incr_delta_depth :
  FStar_Syntax_Syntax.delta_depth -> FStar_Syntax_Syntax.delta_depth =
  fun d  ->
    match d with
    | FStar_Syntax_Syntax.Delta_equational  -> d
    | FStar_Syntax_Syntax.Delta_constant  ->
        FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")
    | FStar_Syntax_Syntax.Delta_defined_at_level i ->
        FStar_Syntax_Syntax.Delta_defined_at_level
          (i + (Prims.parse_int "1"))
    | FStar_Syntax_Syntax.Delta_abstract d1 -> incr_delta_depth d1
  
let incr_delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth =
  fun t  ->
    let uu____5763 = delta_qualifier t  in incr_delta_depth uu____5763
  
let is_unknown : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____5767 =
      let uu____5768 = FStar_Syntax_Subst.compress t  in
      uu____5768.FStar_Syntax_Syntax.n  in
    match uu____5767 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____5771 -> false
  
let rec list_elements :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term Prims.list option =
  fun e  ->
    let uu____5779 = let uu____5789 = unmeta e  in head_and_args uu____5789
       in
    match uu____5779 with
    | (head1,args) ->
        let uu____5808 =
          let uu____5816 =
            let uu____5817 = un_uinst head1  in
            uu____5817.FStar_Syntax_Syntax.n  in
          (uu____5816, args)  in
        (match uu____5808 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____5828) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.nil_lid ->
             Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____5841::(hd1,uu____5843)::(tl1,uu____5845)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.cons_lid ->
             let uu____5879 =
               let uu____5883 =
                 let uu____5887 = list_elements tl1  in
                 FStar_Util.must uu____5887  in
               hd1 :: uu____5883  in
             Some uu____5879
         | uu____5896 -> None)
  
let rec apply_last f l =
  match l with
  | [] -> failwith "apply_last: got empty list"
  | a::[] -> let uu____5927 = f a  in [uu____5927]
  | x::xs -> let uu____5931 = apply_last f xs  in x :: uu____5931 
let dm4f_lid :
  FStar_Syntax_Syntax.eff_decl -> Prims.string -> FStar_Ident.lident =
  fun ed  ->
    fun name  ->
      let p = FStar_Ident.path_of_lid ed.FStar_Syntax_Syntax.mname  in
      let p' =
        apply_last
          (fun s  ->
             Prims.strcat "_dm4f_" (Prims.strcat s (Prims.strcat "_" name)))
          p
         in
      FStar_Ident.lid_of_path p' FStar_Range.dummyRange
  
let rec mk_list :
  FStar_Syntax_Syntax.term ->
    FStar_Range.range ->
      FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term
  =
  fun typ  ->
    fun rng  ->
      fun l  ->
        let ctor l1 =
          let uu____5961 =
            let uu____5964 =
              let uu____5965 =
                FStar_Syntax_Syntax.lid_as_fv l1
                  FStar_Syntax_Syntax.Delta_constant
                  (Some FStar_Syntax_Syntax.Data_ctor)
                 in
              FStar_Syntax_Syntax.Tm_fvar uu____5965  in
            FStar_Syntax_Syntax.mk uu____5964  in
          uu____5961 None rng  in
        let cons1 args pos =
          let uu____5983 =
            let uu____5984 =
              let uu____5985 = ctor FStar_Syntax_Const.cons_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____5985
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____5984 args  in
          uu____5983 None pos  in
        let nil args pos =
          let uu____5999 =
            let uu____6000 =
              let uu____6001 = ctor FStar_Syntax_Const.nil_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____6001
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____6000 args  in
          uu____5999 None pos  in
        let uu____6006 =
          let uu____6007 =
            let uu____6008 = FStar_Syntax_Syntax.iarg typ  in [uu____6008]
             in
          nil uu____6007 rng  in
        FStar_List.fold_right
          (fun t  ->
             fun a  ->
               let uu____6011 =
                 let uu____6012 = FStar_Syntax_Syntax.iarg typ  in
                 let uu____6013 =
                   let uu____6015 = FStar_Syntax_Syntax.as_arg t  in
                   let uu____6016 =
                     let uu____6018 = FStar_Syntax_Syntax.as_arg a  in
                     [uu____6018]  in
                   uu____6015 :: uu____6016  in
                 uu____6012 :: uu____6013  in
               cons1 uu____6011 t.FStar_Syntax_Syntax.pos) l uu____6006
  
let rec eqlist eq1 xs ys =
  match (xs, ys) with
  | ([],[]) -> true
  | (x::xs1,y::ys1) -> (eq1 x y) && (eqlist eq1 xs1 ys1)
  | uu____6062 -> false 
let eqsum e1 e2 x y =
  match (x, y) with
  | (FStar_Util.Inl x1,FStar_Util.Inl y1) -> e1 x1 y1
  | (FStar_Util.Inr x1,FStar_Util.Inr y1) -> e2 x1 y1
  | uu____6135 -> false 
let eqprod e1 e2 x y =
  match (x, y) with | ((x1,x2),(y1,y2)) -> (e1 x1 y1) && (e2 x2 y2) 
let eqopt e x y =
  match (x, y) with | (Some x1,Some y1) -> e x1 y1 | uu____6243 -> false 
let rec term_eq :
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax -> Prims.bool
  =
  fun t1  ->
    fun t2  ->
      let canon_app t =
        match t.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Tm_app uu____6356 ->
            let uu____6366 = head_and_args' t  in
            (match uu____6366 with
             | (hd1,args) ->
                 let uu___180_6388 = t  in
                 {
                   FStar_Syntax_Syntax.n =
                     (FStar_Syntax_Syntax.Tm_app (hd1, args));
                   FStar_Syntax_Syntax.tk =
                     (uu___180_6388.FStar_Syntax_Syntax.tk);
                   FStar_Syntax_Syntax.pos =
                     (uu___180_6388.FStar_Syntax_Syntax.pos);
                   FStar_Syntax_Syntax.vars =
                     (uu___180_6388.FStar_Syntax_Syntax.vars)
                 })
        | uu____6400 -> t  in
      let t11 = canon_app t1  in
      let t21 = canon_app t2  in
      match ((t11.FStar_Syntax_Syntax.n), (t21.FStar_Syntax_Syntax.n)) with
      | (FStar_Syntax_Syntax.Tm_bvar x,FStar_Syntax_Syntax.Tm_bvar y) ->
          x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index
      | (FStar_Syntax_Syntax.Tm_name x,FStar_Syntax_Syntax.Tm_name y) ->
          FStar_Syntax_Syntax.bv_eq x y
      | (FStar_Syntax_Syntax.Tm_fvar x,FStar_Syntax_Syntax.Tm_fvar y) ->
          FStar_Syntax_Syntax.fv_eq x y
      | (FStar_Syntax_Syntax.Tm_uinst (t12,us1),FStar_Syntax_Syntax.Tm_uinst
         (t22,us2)) -> (eqlist eq_univs us1 us2) && (term_eq t12 t22)
      | (FStar_Syntax_Syntax.Tm_constant x,FStar_Syntax_Syntax.Tm_constant y)
          -> x = y
      | (FStar_Syntax_Syntax.Tm_type x,FStar_Syntax_Syntax.Tm_type y) ->
          x = y
      | (FStar_Syntax_Syntax.Tm_abs (b1,t12,k1),FStar_Syntax_Syntax.Tm_abs
         (b2,t22,k2)) -> (eqlist binder_eq b1 b2) && (term_eq t12 t22)
      | (FStar_Syntax_Syntax.Tm_app (f1,a1),FStar_Syntax_Syntax.Tm_app
         (f2,a2)) -> (term_eq f1 f2) && (eqlist arg_eq a1 a2)
      | (FStar_Syntax_Syntax.Tm_arrow (b1,c1),FStar_Syntax_Syntax.Tm_arrow
         (b2,c2)) -> (eqlist binder_eq b1 b2) && (comp_eq c1 c2)
      | (FStar_Syntax_Syntax.Tm_refine (b1,t12),FStar_Syntax_Syntax.Tm_refine
         (b2,t22)) -> (FStar_Syntax_Syntax.bv_eq b1 b2) && (term_eq t12 t22)
      | (FStar_Syntax_Syntax.Tm_match (t12,bs1),FStar_Syntax_Syntax.Tm_match
         (t22,bs2)) -> (term_eq t12 t22) && (eqlist branch_eq bs1 bs2)
      | (uu____6601,uu____6602) -> false

and arg_eq :
  ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) ->
    ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) -> Prims.bool
  =
  fun a1  -> fun a2  -> eqprod term_eq (fun q1  -> fun q2  -> q1 = q2) a1 a2

and binder_eq :
  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) ->
    (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) -> Prims.bool
  =
  fun b1  ->
    fun b2  ->
      eqprod
        (fun b11  ->
           fun b21  ->
             term_eq b11.FStar_Syntax_Syntax.sort
               b21.FStar_Syntax_Syntax.sort) (fun q1  -> fun q2  -> q1 = q2)
        b1 b2

and lcomp_eq c1 c2 = false

and residual_eq r1 r2 = false

and comp_eq :
  (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
      Prims.bool
  =
  fun c1  ->
    fun c2  ->
      match ((c1.FStar_Syntax_Syntax.n), (c2.FStar_Syntax_Syntax.n)) with
      | (FStar_Syntax_Syntax.Total (t1,u1),FStar_Syntax_Syntax.Total (t2,u2))
          -> term_eq t1 t2
      | (FStar_Syntax_Syntax.GTotal (t1,u1),FStar_Syntax_Syntax.GTotal
         (t2,u2)) -> term_eq t1 t2
      | (FStar_Syntax_Syntax.Comp c11,FStar_Syntax_Syntax.Comp c21) ->
          ((((c11.FStar_Syntax_Syntax.comp_univs =
                c21.FStar_Syntax_Syntax.comp_univs)
               &&
               (c11.FStar_Syntax_Syntax.effect_name =
                  c21.FStar_Syntax_Syntax.effect_name))
              &&
              (term_eq c11.FStar_Syntax_Syntax.result_typ
                 c21.FStar_Syntax_Syntax.result_typ))
             &&
             (eqlist arg_eq c11.FStar_Syntax_Syntax.effect_args
                c21.FStar_Syntax_Syntax.effect_args))
            &&
            (eq_flags c11.FStar_Syntax_Syntax.flags
               c21.FStar_Syntax_Syntax.flags)
      | (uu____6675,uu____6676) -> false

and eq_flags :
  FStar_Syntax_Syntax.cflags Prims.list ->
    FStar_Syntax_Syntax.cflags Prims.list -> Prims.bool
  = fun f1  -> fun f2  -> false

and branch_eq :
  ((FStar_Syntax_Syntax.pat',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.withinfo_t *
    (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax option *
    (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax) ->
    ((FStar_Syntax_Syntax.pat',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.withinfo_t *
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax option *
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax) -> Prims.bool
  =
  fun uu____6681  ->
    fun uu____6682  ->
      match (uu____6681, uu____6682) with | ((p1,w1,t1),(p2,w2,t2)) -> false

let rec bottom_fold :
  (FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun f  ->
    fun t  ->
      let ff = bottom_fold f  in
      let tn =
        let uu____6792 = FStar_Syntax_Subst.compress t  in
        uu____6792.FStar_Syntax_Syntax.n  in
      let tn1 =
        match tn with
        | FStar_Syntax_Syntax.Tm_app (f1,args) ->
            let uu____6812 =
              let uu____6822 = ff f1  in
              let uu____6823 =
                FStar_List.map
                  (fun uu____6831  ->
                     match uu____6831 with
                     | (a,q) -> let uu____6838 = ff a  in (uu____6838, q))
                  args
                 in
              (uu____6822, uu____6823)  in
            FStar_Syntax_Syntax.Tm_app uu____6812
        | FStar_Syntax_Syntax.Tm_abs (bs,t1,k) ->
            let uu____6857 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____6857 with
             | (bs1,t') ->
                 let t'' = ff t'  in
                 let uu____6863 =
                   let uu____6873 = FStar_Syntax_Subst.close bs1 t''  in
                   (bs1, uu____6873, k)  in
                 FStar_Syntax_Syntax.Tm_abs uu____6863)
        | FStar_Syntax_Syntax.Tm_arrow (bs,k) -> tn
        | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
            let uu____6893 = let uu____6898 = ff t1  in (uu____6898, us)  in
            FStar_Syntax_Syntax.Tm_uinst uu____6893
        | uu____6899 -> tn  in
      f
        (let uu___181_6900 = t  in
         {
           FStar_Syntax_Syntax.n = tn1;
           FStar_Syntax_Syntax.tk = (uu___181_6900.FStar_Syntax_Syntax.tk);
           FStar_Syntax_Syntax.pos = (uu___181_6900.FStar_Syntax_Syntax.pos);
           FStar_Syntax_Syntax.vars =
             (uu___181_6900.FStar_Syntax_Syntax.vars)
         })
  
let rec sizeof : FStar_Syntax_Syntax.term -> Prims.int =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____6908 ->
        let uu____6923 =
          let uu____6924 = FStar_Syntax_Subst.compress t  in
          sizeof uu____6924  in
        (Prims.parse_int "1") + uu____6923
    | FStar_Syntax_Syntax.Tm_bvar bv ->
        let uu____6926 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____6926
    | FStar_Syntax_Syntax.Tm_name bv ->
        let uu____6928 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____6928
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
        let uu____6935 = sizeof t1  in (FStar_List.length us) + uu____6935
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____6941) ->
        let uu____6954 = sizeof t1  in
        let uu____6955 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____6959  ->
                 match uu____6959 with
                 | (bv,uu____6963) ->
                     let uu____6964 = sizeof bv.FStar_Syntax_Syntax.sort  in
                     acc + uu____6964) (Prims.parse_int "0") bs
           in
        uu____6954 + uu____6955
    | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
        let uu____6981 = sizeof hd1  in
        let uu____6982 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____6986  ->
                 match uu____6986 with
                 | (arg,uu____6990) ->
                     let uu____6991 = sizeof arg  in acc + uu____6991)
            (Prims.parse_int "0") args
           in
        uu____6981 + uu____6982
    | uu____6992 -> (Prims.parse_int "1")
  
let is_synth_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____6996 =
      let uu____6997 = un_uinst t  in uu____6997.FStar_Syntax_Syntax.n  in
    match uu____6996 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.synth_lid
    | uu____7001 -> false
  
let mk_alien b s r =
  let uu____7021 =
    let uu____7024 =
      let uu____7025 =
        let uu____7030 =
          let uu____7031 =
            let uu____7034 = FStar_Dyn.mkdyn b  in (uu____7034, s)  in
          FStar_Syntax_Syntax.Meta_alien uu____7031  in
        (FStar_Syntax_Syntax.tun, uu____7030)  in
      FStar_Syntax_Syntax.Tm_meta uu____7025  in
    FStar_Syntax_Syntax.mk uu____7024  in
  uu____7021 None
    (match r with | Some r1 -> r1 | None  -> FStar_Range.dummyRange)
  
let un_alien : FStar_Syntax_Syntax.term -> FStar_Dyn.dyn =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta
        (uu____7049,FStar_Syntax_Syntax.Meta_alien (blob,uu____7051)) -> blob
    | uu____7056 -> failwith "Something paranormal occurred"
  