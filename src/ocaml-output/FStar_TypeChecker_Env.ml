
open Prims
open FStar_Pervasives

type sig_binding =
(FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt)

type delta_level =
| NoDelta
| Inlining
| Eager_unfolding_only
| Unfold of FStar_Syntax_Syntax.delta_depth
| UnfoldTac


let uu___is_NoDelta : delta_level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NoDelta -> begin
true
end
| uu____17 -> begin
false
end))


let uu___is_Inlining : delta_level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Inlining -> begin
true
end
| uu____23 -> begin
false
end))


let uu___is_Eager_unfolding_only : delta_level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Eager_unfolding_only -> begin
true
end
| uu____29 -> begin
false
end))


let uu___is_Unfold : delta_level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Unfold (_0) -> begin
true
end
| uu____36 -> begin
false
end))


let __proj__Unfold__item___0 : delta_level  ->  FStar_Syntax_Syntax.delta_depth = (fun projectee -> (match (projectee) with
| Unfold (_0) -> begin
_0
end))


let uu___is_UnfoldTac : delta_level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| UnfoldTac -> begin
true
end
| uu____49 -> begin
false
end))

type mlift =
{mlift_wp : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ; mlift_term : (FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term) FStar_Pervasives_Native.option}


let __proj__Mkmlift__item__mlift_wp : mlift  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun projectee -> (match (projectee) with
| {mlift_wp = __fname__mlift_wp; mlift_term = __fname__mlift_term} -> begin
__fname__mlift_wp
end))


let __proj__Mkmlift__item__mlift_term : mlift  ->  (FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term) FStar_Pervasives_Native.option = (fun projectee -> (match (projectee) with
| {mlift_wp = __fname__mlift_wp; mlift_term = __fname__mlift_term} -> begin
__fname__mlift_term
end))

type edge =
{msource : FStar_Ident.lident; mtarget : FStar_Ident.lident; mlift : mlift}


let __proj__Mkedge__item__msource : edge  ->  FStar_Ident.lident = (fun projectee -> (match (projectee) with
| {msource = __fname__msource; mtarget = __fname__mtarget; mlift = __fname__mlift} -> begin
__fname__msource
end))


let __proj__Mkedge__item__mtarget : edge  ->  FStar_Ident.lident = (fun projectee -> (match (projectee) with
| {msource = __fname__msource; mtarget = __fname__mtarget; mlift = __fname__mlift} -> begin
__fname__mtarget
end))


let __proj__Mkedge__item__mlift : edge  ->  mlift = (fun projectee -> (match (projectee) with
| {msource = __fname__msource; mtarget = __fname__mtarget; mlift = __fname__mlift} -> begin
__fname__mlift
end))

type effects =
{decls : (FStar_Syntax_Syntax.eff_decl * FStar_Syntax_Syntax.qualifier Prims.list) Prims.list; order : edge Prims.list; joins : (FStar_Ident.lident * FStar_Ident.lident * FStar_Ident.lident * mlift * mlift) Prims.list}


let __proj__Mkeffects__item__decls : effects  ->  (FStar_Syntax_Syntax.eff_decl * FStar_Syntax_Syntax.qualifier Prims.list) Prims.list = (fun projectee -> (match (projectee) with
| {decls = __fname__decls; order = __fname__order; joins = __fname__joins} -> begin
__fname__decls
end))


let __proj__Mkeffects__item__order : effects  ->  edge Prims.list = (fun projectee -> (match (projectee) with
| {decls = __fname__decls; order = __fname__order; joins = __fname__joins} -> begin
__fname__order
end))


let __proj__Mkeffects__item__joins : effects  ->  (FStar_Ident.lident * FStar_Ident.lident * FStar_Ident.lident * mlift * mlift) Prims.list = (fun projectee -> (match (projectee) with
| {decls = __fname__decls; order = __fname__order; joins = __fname__joins} -> begin
__fname__joins
end))


type name_prefix =
Prims.string Prims.list


type proof_namespace =
(name_prefix * Prims.bool) Prims.list


type cached_elt =
(((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option)) FStar_Util.either * FStar_Range.range)


type goal =
FStar_Syntax_Syntax.term

type env =
{solver : solver_t; range : FStar_Range.range; curmodule : FStar_Ident.lident; gamma : FStar_Syntax_Syntax.binding Prims.list; gamma_sig : sig_binding Prims.list; gamma_cache : cached_elt FStar_Util.smap; modules : FStar_Syntax_Syntax.modul Prims.list; expected_typ : FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option; sigtab : FStar_Syntax_Syntax.sigelt FStar_Util.smap; is_pattern : Prims.bool; instantiate_imp : Prims.bool; effects : effects; generalize : Prims.bool; letrecs : (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.univ_names) Prims.list; top_level : Prims.bool; check_uvars : Prims.bool; use_eq : Prims.bool; is_iface : Prims.bool; admit : Prims.bool; lax : Prims.bool; lax_universes : Prims.bool; failhard : Prims.bool; nosynth : Prims.bool; tc_term : env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * guard_t); type_of : env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * guard_t); universe_of : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe; check_type_of : Prims.bool  ->  env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  guard_t; use_bv_sorts : Prims.bool; qtbl_name_and_index : (Prims.int FStar_Util.smap * (FStar_Ident.lident * Prims.int) FStar_Pervasives_Native.option); normalized_eff_names : FStar_Ident.lident FStar_Util.smap; proof_ns : proof_namespace; synth_hook : env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term; splice : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.sigelt Prims.list; is_native_tactic : FStar_Ident.lid  ->  Prims.bool; identifier_info : FStar_TypeChecker_Common.id_info_table FStar_ST.ref; tc_hooks : tcenv_hooks; dsenv : FStar_Syntax_DsEnv.env; dep_graph : FStar_Parser_Dep.deps} 
 and solver_t =
{init : env  ->  unit; push : Prims.string  ->  unit; pop : Prims.string  ->  unit; encode_modul : env  ->  FStar_Syntax_Syntax.modul  ->  unit; encode_sig : env  ->  FStar_Syntax_Syntax.sigelt  ->  unit; preprocess : env  ->  goal  ->  (env * goal * FStar_Options.optionstate) Prims.list; solve : (unit  ->  Prims.string) FStar_Pervasives_Native.option  ->  env  ->  FStar_Syntax_Syntax.typ  ->  unit; finish : unit  ->  unit; refresh : unit  ->  unit} 
 and guard_t =
{guard_f : FStar_TypeChecker_Common.guard_formula; deferred : FStar_TypeChecker_Common.deferred; univ_ineqs : (FStar_Syntax_Syntax.universe Prims.list * FStar_TypeChecker_Common.univ_ineq Prims.list); implicits : (Prims.string * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.ctx_uvar * FStar_Range.range * Prims.bool) Prims.list} 
 and tcenv_hooks =
{tc_push_in_gamma_hook : env  ->  (FStar_Syntax_Syntax.binding, sig_binding) FStar_Util.either  ->  unit}


let __proj__Mkenv__item__solver : env  ->  solver_t = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__solver
end))


let __proj__Mkenv__item__range : env  ->  FStar_Range.range = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__range
end))


let __proj__Mkenv__item__curmodule : env  ->  FStar_Ident.lident = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__curmodule
end))


let __proj__Mkenv__item__gamma : env  ->  FStar_Syntax_Syntax.binding Prims.list = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__gamma
end))


let __proj__Mkenv__item__gamma_sig : env  ->  sig_binding Prims.list = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__gamma_sig
end))


let __proj__Mkenv__item__gamma_cache : env  ->  cached_elt FStar_Util.smap = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__gamma_cache
end))


let __proj__Mkenv__item__modules : env  ->  FStar_Syntax_Syntax.modul Prims.list = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__modules
end))


let __proj__Mkenv__item__expected_typ : env  ->  FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__expected_typ
end))


let __proj__Mkenv__item__sigtab : env  ->  FStar_Syntax_Syntax.sigelt FStar_Util.smap = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__sigtab
end))


let __proj__Mkenv__item__is_pattern : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__is_pattern
end))


let __proj__Mkenv__item__instantiate_imp : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__instantiate_imp
end))


let __proj__Mkenv__item__effects : env  ->  effects = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__effects
end))


let __proj__Mkenv__item__generalize : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__generalize
end))


let __proj__Mkenv__item__letrecs : env  ->  (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.univ_names) Prims.list = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__letrecs
end))


let __proj__Mkenv__item__top_level : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__top_level
end))


let __proj__Mkenv__item__check_uvars : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__check_uvars
end))


let __proj__Mkenv__item__use_eq : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__use_eq
end))


let __proj__Mkenv__item__is_iface : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__is_iface
end))


let __proj__Mkenv__item__admit : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__admit
end))


let __proj__Mkenv__item__lax : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__lax
end))


let __proj__Mkenv__item__lax_universes : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__lax_universes
end))


let __proj__Mkenv__item__failhard : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__failhard
end))


let __proj__Mkenv__item__nosynth : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__nosynth
end))


let __proj__Mkenv__item__tc_term : env  ->  env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * guard_t) = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__tc_term
end))


let __proj__Mkenv__item__type_of : env  ->  env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * guard_t) = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__type_of
end))


let __proj__Mkenv__item__universe_of : env  ->  env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__universe_of
end))


let __proj__Mkenv__item__check_type_of : env  ->  Prims.bool  ->  env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  guard_t = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__check_type_of
end))


let __proj__Mkenv__item__use_bv_sorts : env  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__use_bv_sorts
end))


let __proj__Mkenv__item__qtbl_name_and_index : env  ->  (Prims.int FStar_Util.smap * (FStar_Ident.lident * Prims.int) FStar_Pervasives_Native.option) = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__qtbl_name_and_index
end))


let __proj__Mkenv__item__normalized_eff_names : env  ->  FStar_Ident.lident FStar_Util.smap = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__normalized_eff_names
end))


let __proj__Mkenv__item__proof_ns : env  ->  proof_namespace = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__proof_ns
end))


let __proj__Mkenv__item__synth_hook : env  ->  env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__synth_hook
end))


let __proj__Mkenv__item__splice : env  ->  env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.sigelt Prims.list = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__splice
end))


let __proj__Mkenv__item__is_native_tactic : env  ->  FStar_Ident.lid  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__is_native_tactic
end))


let __proj__Mkenv__item__identifier_info : env  ->  FStar_TypeChecker_Common.id_info_table FStar_ST.ref = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__identifier_info
end))


let __proj__Mkenv__item__tc_hooks : env  ->  tcenv_hooks = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__tc_hooks
end))


let __proj__Mkenv__item__dsenv : env  ->  FStar_Syntax_DsEnv.env = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__dsenv
end))


let __proj__Mkenv__item__dep_graph : env  ->  FStar_Parser_Dep.deps = (fun projectee -> (match (projectee) with
| {solver = __fname__solver; range = __fname__range; curmodule = __fname__curmodule; gamma = __fname__gamma; gamma_sig = __fname__gamma_sig; gamma_cache = __fname__gamma_cache; modules = __fname__modules; expected_typ = __fname__expected_typ; sigtab = __fname__sigtab; is_pattern = __fname__is_pattern; instantiate_imp = __fname__instantiate_imp; effects = __fname__effects; generalize = __fname__generalize; letrecs = __fname__letrecs; top_level = __fname__top_level; check_uvars = __fname__check_uvars; use_eq = __fname__use_eq; is_iface = __fname__is_iface; admit = __fname__admit; lax = __fname__lax; lax_universes = __fname__lax_universes; failhard = __fname__failhard; nosynth = __fname__nosynth; tc_term = __fname__tc_term; type_of = __fname__type_of; universe_of = __fname__universe_of; check_type_of = __fname__check_type_of; use_bv_sorts = __fname__use_bv_sorts; qtbl_name_and_index = __fname__qtbl_name_and_index; normalized_eff_names = __fname__normalized_eff_names; proof_ns = __fname__proof_ns; synth_hook = __fname__synth_hook; splice = __fname__splice; is_native_tactic = __fname__is_native_tactic; identifier_info = __fname__identifier_info; tc_hooks = __fname__tc_hooks; dsenv = __fname__dsenv; dep_graph = __fname__dep_graph} -> begin
__fname__dep_graph
end))


let __proj__Mksolver_t__item__init : solver_t  ->  env  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__init
end))


let __proj__Mksolver_t__item__push : solver_t  ->  Prims.string  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__push
end))


let __proj__Mksolver_t__item__pop : solver_t  ->  Prims.string  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__pop
end))


let __proj__Mksolver_t__item__encode_modul : solver_t  ->  env  ->  FStar_Syntax_Syntax.modul  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__encode_modul
end))


let __proj__Mksolver_t__item__encode_sig : solver_t  ->  env  ->  FStar_Syntax_Syntax.sigelt  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__encode_sig
end))


let __proj__Mksolver_t__item__preprocess : solver_t  ->  env  ->  goal  ->  (env * goal * FStar_Options.optionstate) Prims.list = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__preprocess
end))


let __proj__Mksolver_t__item__solve : solver_t  ->  (unit  ->  Prims.string) FStar_Pervasives_Native.option  ->  env  ->  FStar_Syntax_Syntax.typ  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__solve
end))


let __proj__Mksolver_t__item__finish : solver_t  ->  unit  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__finish
end))


let __proj__Mksolver_t__item__refresh : solver_t  ->  unit  ->  unit = (fun projectee -> (match (projectee) with
| {init = __fname__init; push = __fname__push; pop = __fname__pop; encode_modul = __fname__encode_modul; encode_sig = __fname__encode_sig; preprocess = __fname__preprocess; solve = __fname__solve; finish = __fname__finish; refresh = __fname__refresh} -> begin
__fname__refresh
end))


let __proj__Mkguard_t__item__guard_f : guard_t  ->  FStar_TypeChecker_Common.guard_formula = (fun projectee -> (match (projectee) with
| {guard_f = __fname__guard_f; deferred = __fname__deferred; univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits} -> begin
__fname__guard_f
end))


let __proj__Mkguard_t__item__deferred : guard_t  ->  FStar_TypeChecker_Common.deferred = (fun projectee -> (match (projectee) with
| {guard_f = __fname__guard_f; deferred = __fname__deferred; univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits} -> begin
__fname__deferred
end))


let __proj__Mkguard_t__item__univ_ineqs : guard_t  ->  (FStar_Syntax_Syntax.universe Prims.list * FStar_TypeChecker_Common.univ_ineq Prims.list) = (fun projectee -> (match (projectee) with
| {guard_f = __fname__guard_f; deferred = __fname__deferred; univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits} -> begin
__fname__univ_ineqs
end))


let __proj__Mkguard_t__item__implicits : guard_t  ->  (Prims.string * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.ctx_uvar * FStar_Range.range * Prims.bool) Prims.list = (fun projectee -> (match (projectee) with
| {guard_f = __fname__guard_f; deferred = __fname__deferred; univ_ineqs = __fname__univ_ineqs; implicits = __fname__implicits} -> begin
__fname__implicits
end))


let __proj__Mktcenv_hooks__item__tc_push_in_gamma_hook : tcenv_hooks  ->  env  ->  (FStar_Syntax_Syntax.binding, sig_binding) FStar_Util.either  ->  unit = (fun projectee -> (match (projectee) with
| {tc_push_in_gamma_hook = __fname__tc_push_in_gamma_hook} -> begin
__fname__tc_push_in_gamma_hook
end))


type implicits =
(Prims.string * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.ctx_uvar * FStar_Range.range * Prims.bool) Prims.list


let rename_gamma : FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_Syntax_Syntax.binding Prims.list  ->  FStar_Syntax_Syntax.binding Prims.list = (fun subst1 gamma -> (FStar_All.pipe_right gamma (FStar_List.map (fun uu___74_7551 -> (match (uu___74_7551) with
| FStar_Syntax_Syntax.Binding_var (x) -> begin
(

let y = (

let uu____7554 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Subst.subst subst1 uu____7554))
in (

let uu____7555 = (

let uu____7556 = (FStar_Syntax_Subst.compress y)
in uu____7556.FStar_Syntax_Syntax.n)
in (match (uu____7555) with
| FStar_Syntax_Syntax.Tm_name (y1) -> begin
(

let uu____7560 = (

let uu___88_7561 = y1
in (

let uu____7562 = (FStar_Syntax_Subst.subst subst1 x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = uu___88_7561.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___88_7561.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = uu____7562}))
in FStar_Syntax_Syntax.Binding_var (uu____7560))
end
| uu____7565 -> begin
(failwith "Not a renaming")
end)))
end
| b -> begin
b
end)))))


let rename_env : FStar_Syntax_Syntax.subst_t  ->  env  ->  env = (fun subst1 env -> (

let uu___89_7577 = env
in (

let uu____7578 = (rename_gamma subst1 env.gamma)
in {solver = uu___89_7577.solver; range = uu___89_7577.range; curmodule = uu___89_7577.curmodule; gamma = uu____7578; gamma_sig = uu___89_7577.gamma_sig; gamma_cache = uu___89_7577.gamma_cache; modules = uu___89_7577.modules; expected_typ = uu___89_7577.expected_typ; sigtab = uu___89_7577.sigtab; is_pattern = uu___89_7577.is_pattern; instantiate_imp = uu___89_7577.instantiate_imp; effects = uu___89_7577.effects; generalize = uu___89_7577.generalize; letrecs = uu___89_7577.letrecs; top_level = uu___89_7577.top_level; check_uvars = uu___89_7577.check_uvars; use_eq = uu___89_7577.use_eq; is_iface = uu___89_7577.is_iface; admit = uu___89_7577.admit; lax = uu___89_7577.lax; lax_universes = uu___89_7577.lax_universes; failhard = uu___89_7577.failhard; nosynth = uu___89_7577.nosynth; tc_term = uu___89_7577.tc_term; type_of = uu___89_7577.type_of; universe_of = uu___89_7577.universe_of; check_type_of = uu___89_7577.check_type_of; use_bv_sorts = uu___89_7577.use_bv_sorts; qtbl_name_and_index = uu___89_7577.qtbl_name_and_index; normalized_eff_names = uu___89_7577.normalized_eff_names; proof_ns = uu___89_7577.proof_ns; synth_hook = uu___89_7577.synth_hook; splice = uu___89_7577.splice; is_native_tactic = uu___89_7577.is_native_tactic; identifier_info = uu___89_7577.identifier_info; tc_hooks = uu___89_7577.tc_hooks; dsenv = uu___89_7577.dsenv; dep_graph = uu___89_7577.dep_graph})))


let default_tc_hooks : tcenv_hooks = {tc_push_in_gamma_hook = (fun uu____7585 uu____7586 -> ())}


let tc_hooks : env  ->  tcenv_hooks = (fun env -> env.tc_hooks)


let set_tc_hooks : env  ->  tcenv_hooks  ->  env = (fun env hooks -> (

let uu___90_7606 = env
in {solver = uu___90_7606.solver; range = uu___90_7606.range; curmodule = uu___90_7606.curmodule; gamma = uu___90_7606.gamma; gamma_sig = uu___90_7606.gamma_sig; gamma_cache = uu___90_7606.gamma_cache; modules = uu___90_7606.modules; expected_typ = uu___90_7606.expected_typ; sigtab = uu___90_7606.sigtab; is_pattern = uu___90_7606.is_pattern; instantiate_imp = uu___90_7606.instantiate_imp; effects = uu___90_7606.effects; generalize = uu___90_7606.generalize; letrecs = uu___90_7606.letrecs; top_level = uu___90_7606.top_level; check_uvars = uu___90_7606.check_uvars; use_eq = uu___90_7606.use_eq; is_iface = uu___90_7606.is_iface; admit = uu___90_7606.admit; lax = uu___90_7606.lax; lax_universes = uu___90_7606.lax_universes; failhard = uu___90_7606.failhard; nosynth = uu___90_7606.nosynth; tc_term = uu___90_7606.tc_term; type_of = uu___90_7606.type_of; universe_of = uu___90_7606.universe_of; check_type_of = uu___90_7606.check_type_of; use_bv_sorts = uu___90_7606.use_bv_sorts; qtbl_name_and_index = uu___90_7606.qtbl_name_and_index; normalized_eff_names = uu___90_7606.normalized_eff_names; proof_ns = uu___90_7606.proof_ns; synth_hook = uu___90_7606.synth_hook; splice = uu___90_7606.splice; is_native_tactic = uu___90_7606.is_native_tactic; identifier_info = uu___90_7606.identifier_info; tc_hooks = hooks; dsenv = uu___90_7606.dsenv; dep_graph = uu___90_7606.dep_graph}))


let set_dep_graph : env  ->  FStar_Parser_Dep.deps  ->  env = (fun e g -> (

let uu___91_7617 = e
in {solver = uu___91_7617.solver; range = uu___91_7617.range; curmodule = uu___91_7617.curmodule; gamma = uu___91_7617.gamma; gamma_sig = uu___91_7617.gamma_sig; gamma_cache = uu___91_7617.gamma_cache; modules = uu___91_7617.modules; expected_typ = uu___91_7617.expected_typ; sigtab = uu___91_7617.sigtab; is_pattern = uu___91_7617.is_pattern; instantiate_imp = uu___91_7617.instantiate_imp; effects = uu___91_7617.effects; generalize = uu___91_7617.generalize; letrecs = uu___91_7617.letrecs; top_level = uu___91_7617.top_level; check_uvars = uu___91_7617.check_uvars; use_eq = uu___91_7617.use_eq; is_iface = uu___91_7617.is_iface; admit = uu___91_7617.admit; lax = uu___91_7617.lax; lax_universes = uu___91_7617.lax_universes; failhard = uu___91_7617.failhard; nosynth = uu___91_7617.nosynth; tc_term = uu___91_7617.tc_term; type_of = uu___91_7617.type_of; universe_of = uu___91_7617.universe_of; check_type_of = uu___91_7617.check_type_of; use_bv_sorts = uu___91_7617.use_bv_sorts; qtbl_name_and_index = uu___91_7617.qtbl_name_and_index; normalized_eff_names = uu___91_7617.normalized_eff_names; proof_ns = uu___91_7617.proof_ns; synth_hook = uu___91_7617.synth_hook; splice = uu___91_7617.splice; is_native_tactic = uu___91_7617.is_native_tactic; identifier_info = uu___91_7617.identifier_info; tc_hooks = uu___91_7617.tc_hooks; dsenv = uu___91_7617.dsenv; dep_graph = g}))


let dep_graph : env  ->  FStar_Parser_Dep.deps = (fun e -> e.dep_graph)


type env_t =
env


type sigtable =
FStar_Syntax_Syntax.sigelt FStar_Util.smap


let should_verify : env  ->  Prims.bool = (fun env -> (((not (env.lax)) && (not (env.admit))) && (FStar_Options.should_verify env.curmodule.FStar_Ident.str)))


let visible_at : delta_level  ->  FStar_Syntax_Syntax.qualifier  ->  Prims.bool = (fun d q -> (match (((d), (q))) with
| (NoDelta, uu____7640) -> begin
true
end
| (Eager_unfolding_only, FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen) -> begin
true
end
| (Unfold (uu____7641), FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen) -> begin
true
end
| (Unfold (uu____7642), FStar_Syntax_Syntax.Visible_default) -> begin
true
end
| (Inlining, FStar_Syntax_Syntax.Inline_for_extraction) -> begin
true
end
| uu____7643 -> begin
false
end))


let default_table_size : Prims.int = (Prims.parse_int "200")


let new_sigtab : 'Auu____7652 . unit  ->  'Auu____7652 FStar_Util.smap = (fun uu____7659 -> (FStar_Util.smap_create default_table_size))


let new_gamma_cache : 'Auu____7664 . unit  ->  'Auu____7664 FStar_Util.smap = (fun uu____7671 -> (FStar_Util.smap_create (Prims.parse_int "100")))


let initial_env : FStar_Parser_Dep.deps  ->  (env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * guard_t))  ->  (env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * guard_t))  ->  (env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe)  ->  (Prims.bool  ->  env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  guard_t)  ->  solver_t  ->  FStar_Ident.lident  ->  env = (fun deps tc_term type_of universe_of check_type_of solver module_lid -> (

let uu____7781 = (new_gamma_cache ())
in (

let uu____7784 = (new_sigtab ())
in (

let uu____7787 = (

let uu____7800 = (FStar_Util.smap_create (Prims.parse_int "10"))
in ((uu____7800), (FStar_Pervasives_Native.None)))
in (

let uu____7815 = (FStar_Util.smap_create (Prims.parse_int "20"))
in (

let uu____7818 = (FStar_Options.using_facts_from ())
in (

let uu____7819 = (FStar_Util.mk_ref FStar_TypeChecker_Common.id_info_table_empty)
in (

let uu____7822 = (FStar_Syntax_DsEnv.empty_env ())
in {solver = solver; range = FStar_Range.dummyRange; curmodule = module_lid; gamma = []; gamma_sig = []; gamma_cache = uu____7781; modules = []; expected_typ = FStar_Pervasives_Native.None; sigtab = uu____7784; is_pattern = false; instantiate_imp = true; effects = {decls = []; order = []; joins = []}; generalize = true; letrecs = []; top_level = false; check_uvars = false; use_eq = false; is_iface = false; admit = false; lax = false; lax_universes = false; failhard = false; nosynth = false; tc_term = tc_term; type_of = type_of; universe_of = universe_of; check_type_of = check_type_of; use_bv_sorts = false; qtbl_name_and_index = uu____7787; normalized_eff_names = uu____7815; proof_ns = uu____7818; synth_hook = (fun e g tau -> (failwith "no synthesizer available")); splice = (fun e tau -> (failwith "no splicer available")); is_native_tactic = (fun uu____7858 -> false); identifier_info = uu____7819; tc_hooks = default_tc_hooks; dsenv = uu____7822; dep_graph = deps}))))))))


let dsenv : env  ->  FStar_Syntax_DsEnv.env = (fun env -> env.dsenv)


let sigtab : env  ->  FStar_Syntax_Syntax.sigelt FStar_Util.smap = (fun env -> env.sigtab)


let gamma_cache : env  ->  cached_elt FStar_Util.smap = (fun env -> env.gamma_cache)


let query_indices : (FStar_Ident.lident * Prims.int) Prims.list Prims.list FStar_ST.ref = (FStar_Util.mk_ref (([])::[]))


let push_query_indices : unit  ->  unit = (fun uu____7949 -> (

let uu____7950 = (FStar_ST.op_Bang query_indices)
in (match (uu____7950) with
| [] -> begin
(failwith "Empty query indices!")
end
| uu____8004 -> begin
(

let uu____8013 = (

let uu____8022 = (

let uu____8029 = (FStar_ST.op_Bang query_indices)
in (FStar_List.hd uu____8029))
in (

let uu____8083 = (FStar_ST.op_Bang query_indices)
in (uu____8022)::uu____8083))
in (FStar_ST.op_Colon_Equals query_indices uu____8013))
end)))


let pop_query_indices : unit  ->  unit = (fun uu____8180 -> (

let uu____8181 = (FStar_ST.op_Bang query_indices)
in (match (uu____8181) with
| [] -> begin
(failwith "Empty query indices!")
end
| (hd1)::tl1 -> begin
(FStar_ST.op_Colon_Equals query_indices tl1)
end)))


let add_query_index : (FStar_Ident.lident * Prims.int)  ->  unit = (fun uu____8304 -> (match (uu____8304) with
| (l, n1) -> begin
(

let uu____8311 = (FStar_ST.op_Bang query_indices)
in (match (uu____8311) with
| (hd1)::tl1 -> begin
(FStar_ST.op_Colon_Equals query_indices (((((l), (n1)))::hd1)::tl1))
end
| uu____8430 -> begin
(failwith "Empty query indices")
end))
end))


let peek_query_indices : unit  ->  (FStar_Ident.lident * Prims.int) Prims.list = (fun uu____8449 -> (

let uu____8450 = (FStar_ST.op_Bang query_indices)
in (FStar_List.hd uu____8450)))


let stack : env Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let push_stack : env  ->  env = (fun env -> ((

let uu____8527 = (

let uu____8530 = (FStar_ST.op_Bang stack)
in (env)::uu____8530)
in (FStar_ST.op_Colon_Equals stack uu____8527));
(

let uu___92_8587 = env
in (

let uu____8588 = (FStar_Util.smap_copy (gamma_cache env))
in (

let uu____8591 = (FStar_Util.smap_copy (sigtab env))
in (

let uu____8594 = (

let uu____8607 = (

let uu____8610 = (FStar_All.pipe_right env.qtbl_name_and_index FStar_Pervasives_Native.fst)
in (FStar_Util.smap_copy uu____8610))
in (

let uu____8635 = (FStar_All.pipe_right env.qtbl_name_and_index FStar_Pervasives_Native.snd)
in ((uu____8607), (uu____8635))))
in (

let uu____8676 = (FStar_Util.smap_copy env.normalized_eff_names)
in (

let uu____8679 = (

let uu____8682 = (FStar_ST.op_Bang env.identifier_info)
in (FStar_Util.mk_ref uu____8682))
in {solver = uu___92_8587.solver; range = uu___92_8587.range; curmodule = uu___92_8587.curmodule; gamma = uu___92_8587.gamma; gamma_sig = uu___92_8587.gamma_sig; gamma_cache = uu____8588; modules = uu___92_8587.modules; expected_typ = uu___92_8587.expected_typ; sigtab = uu____8591; is_pattern = uu___92_8587.is_pattern; instantiate_imp = uu___92_8587.instantiate_imp; effects = uu___92_8587.effects; generalize = uu___92_8587.generalize; letrecs = uu___92_8587.letrecs; top_level = uu___92_8587.top_level; check_uvars = uu___92_8587.check_uvars; use_eq = uu___92_8587.use_eq; is_iface = uu___92_8587.is_iface; admit = uu___92_8587.admit; lax = uu___92_8587.lax; lax_universes = uu___92_8587.lax_universes; failhard = uu___92_8587.failhard; nosynth = uu___92_8587.nosynth; tc_term = uu___92_8587.tc_term; type_of = uu___92_8587.type_of; universe_of = uu___92_8587.universe_of; check_type_of = uu___92_8587.check_type_of; use_bv_sorts = uu___92_8587.use_bv_sorts; qtbl_name_and_index = uu____8594; normalized_eff_names = uu____8676; proof_ns = uu___92_8587.proof_ns; synth_hook = uu___92_8587.synth_hook; splice = uu___92_8587.splice; is_native_tactic = uu___92_8587.is_native_tactic; identifier_info = uu____8679; tc_hooks = uu___92_8587.tc_hooks; dsenv = uu___92_8587.dsenv; dep_graph = uu___92_8587.dep_graph}))))));
))


let pop_stack : unit  ->  env = (fun uu____8732 -> (

let uu____8733 = (FStar_ST.op_Bang stack)
in (match (uu____8733) with
| (env)::tl1 -> begin
((FStar_ST.op_Colon_Equals stack tl1);
env;
)
end
| uu____8795 -> begin
(failwith "Impossible: Too many pops")
end)))


let push : env  ->  Prims.string  ->  env = (fun env msg -> ((push_query_indices ());
(env.solver.push msg);
(push_stack env);
))


let pop : env  ->  Prims.string  ->  env = (fun env msg -> ((env.solver.pop msg);
(pop_query_indices ());
(pop_stack ());
))


let incr_query_index : env  ->  env = (fun env -> (

let qix = (peek_query_indices ())
in (match (env.qtbl_name_and_index) with
| (uu____8834, FStar_Pervasives_Native.None) -> begin
env
end
| (tbl, FStar_Pervasives_Native.Some (l, n1)) -> begin
(

let uu____8866 = (FStar_All.pipe_right qix (FStar_List.tryFind (fun uu____8892 -> (match (uu____8892) with
| (m, uu____8898) -> begin
(FStar_Ident.lid_equals l m)
end))))
in (match (uu____8866) with
| FStar_Pervasives_Native.None -> begin
(

let next = (n1 + (Prims.parse_int "1"))
in ((add_query_index ((l), (next)));
(FStar_Util.smap_add tbl l.FStar_Ident.str next);
(

let uu___93_8906 = env
in {solver = uu___93_8906.solver; range = uu___93_8906.range; curmodule = uu___93_8906.curmodule; gamma = uu___93_8906.gamma; gamma_sig = uu___93_8906.gamma_sig; gamma_cache = uu___93_8906.gamma_cache; modules = uu___93_8906.modules; expected_typ = uu___93_8906.expected_typ; sigtab = uu___93_8906.sigtab; is_pattern = uu___93_8906.is_pattern; instantiate_imp = uu___93_8906.instantiate_imp; effects = uu___93_8906.effects; generalize = uu___93_8906.generalize; letrecs = uu___93_8906.letrecs; top_level = uu___93_8906.top_level; check_uvars = uu___93_8906.check_uvars; use_eq = uu___93_8906.use_eq; is_iface = uu___93_8906.is_iface; admit = uu___93_8906.admit; lax = uu___93_8906.lax; lax_universes = uu___93_8906.lax_universes; failhard = uu___93_8906.failhard; nosynth = uu___93_8906.nosynth; tc_term = uu___93_8906.tc_term; type_of = uu___93_8906.type_of; universe_of = uu___93_8906.universe_of; check_type_of = uu___93_8906.check_type_of; use_bv_sorts = uu___93_8906.use_bv_sorts; qtbl_name_and_index = ((tbl), (FStar_Pervasives_Native.Some (((l), (next))))); normalized_eff_names = uu___93_8906.normalized_eff_names; proof_ns = uu___93_8906.proof_ns; synth_hook = uu___93_8906.synth_hook; splice = uu___93_8906.splice; is_native_tactic = uu___93_8906.is_native_tactic; identifier_info = uu___93_8906.identifier_info; tc_hooks = uu___93_8906.tc_hooks; dsenv = uu___93_8906.dsenv; dep_graph = uu___93_8906.dep_graph});
))
end
| FStar_Pervasives_Native.Some (uu____8919, m) -> begin
(

let next = (m + (Prims.parse_int "1"))
in ((add_query_index ((l), (next)));
(FStar_Util.smap_add tbl l.FStar_Ident.str next);
(

let uu___94_8928 = env
in {solver = uu___94_8928.solver; range = uu___94_8928.range; curmodule = uu___94_8928.curmodule; gamma = uu___94_8928.gamma; gamma_sig = uu___94_8928.gamma_sig; gamma_cache = uu___94_8928.gamma_cache; modules = uu___94_8928.modules; expected_typ = uu___94_8928.expected_typ; sigtab = uu___94_8928.sigtab; is_pattern = uu___94_8928.is_pattern; instantiate_imp = uu___94_8928.instantiate_imp; effects = uu___94_8928.effects; generalize = uu___94_8928.generalize; letrecs = uu___94_8928.letrecs; top_level = uu___94_8928.top_level; check_uvars = uu___94_8928.check_uvars; use_eq = uu___94_8928.use_eq; is_iface = uu___94_8928.is_iface; admit = uu___94_8928.admit; lax = uu___94_8928.lax; lax_universes = uu___94_8928.lax_universes; failhard = uu___94_8928.failhard; nosynth = uu___94_8928.nosynth; tc_term = uu___94_8928.tc_term; type_of = uu___94_8928.type_of; universe_of = uu___94_8928.universe_of; check_type_of = uu___94_8928.check_type_of; use_bv_sorts = uu___94_8928.use_bv_sorts; qtbl_name_and_index = ((tbl), (FStar_Pervasives_Native.Some (((l), (next))))); normalized_eff_names = uu___94_8928.normalized_eff_names; proof_ns = uu___94_8928.proof_ns; synth_hook = uu___94_8928.synth_hook; splice = uu___94_8928.splice; is_native_tactic = uu___94_8928.is_native_tactic; identifier_info = uu___94_8928.identifier_info; tc_hooks = uu___94_8928.tc_hooks; dsenv = uu___94_8928.dsenv; dep_graph = uu___94_8928.dep_graph});
))
end))
end)))


let debug : env  ->  FStar_Options.debug_level_t  ->  Prims.bool = (fun env l -> (FStar_Options.debug_at_level env.curmodule.FStar_Ident.str l))


let set_range : env  ->  FStar_Range.range  ->  env = (fun e r -> (match ((Prims.op_Equality r FStar_Range.dummyRange)) with
| true -> begin
e
end
| uu____8961 -> begin
(

let uu___95_8962 = e
in {solver = uu___95_8962.solver; range = r; curmodule = uu___95_8962.curmodule; gamma = uu___95_8962.gamma; gamma_sig = uu___95_8962.gamma_sig; gamma_cache = uu___95_8962.gamma_cache; modules = uu___95_8962.modules; expected_typ = uu___95_8962.expected_typ; sigtab = uu___95_8962.sigtab; is_pattern = uu___95_8962.is_pattern; instantiate_imp = uu___95_8962.instantiate_imp; effects = uu___95_8962.effects; generalize = uu___95_8962.generalize; letrecs = uu___95_8962.letrecs; top_level = uu___95_8962.top_level; check_uvars = uu___95_8962.check_uvars; use_eq = uu___95_8962.use_eq; is_iface = uu___95_8962.is_iface; admit = uu___95_8962.admit; lax = uu___95_8962.lax; lax_universes = uu___95_8962.lax_universes; failhard = uu___95_8962.failhard; nosynth = uu___95_8962.nosynth; tc_term = uu___95_8962.tc_term; type_of = uu___95_8962.type_of; universe_of = uu___95_8962.universe_of; check_type_of = uu___95_8962.check_type_of; use_bv_sorts = uu___95_8962.use_bv_sorts; qtbl_name_and_index = uu___95_8962.qtbl_name_and_index; normalized_eff_names = uu___95_8962.normalized_eff_names; proof_ns = uu___95_8962.proof_ns; synth_hook = uu___95_8962.synth_hook; splice = uu___95_8962.splice; is_native_tactic = uu___95_8962.is_native_tactic; identifier_info = uu___95_8962.identifier_info; tc_hooks = uu___95_8962.tc_hooks; dsenv = uu___95_8962.dsenv; dep_graph = uu___95_8962.dep_graph})
end))


let get_range : env  ->  FStar_Range.range = (fun e -> e.range)


let toggle_id_info : env  ->  Prims.bool  ->  unit = (fun env enabled -> (

let uu____8978 = (

let uu____8979 = (FStar_ST.op_Bang env.identifier_info)
in (FStar_TypeChecker_Common.id_info_toggle uu____8979 enabled))
in (FStar_ST.op_Colon_Equals env.identifier_info uu____8978)))


let insert_bv_info : env  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.typ  ->  unit = (fun env bv ty -> (

let uu____9041 = (

let uu____9042 = (FStar_ST.op_Bang env.identifier_info)
in (FStar_TypeChecker_Common.id_info_insert_bv uu____9042 bv ty))
in (FStar_ST.op_Colon_Equals env.identifier_info uu____9041)))


let insert_fv_info : env  ->  FStar_Syntax_Syntax.fv  ->  FStar_Syntax_Syntax.typ  ->  unit = (fun env fv ty -> (

let uu____9104 = (

let uu____9105 = (FStar_ST.op_Bang env.identifier_info)
in (FStar_TypeChecker_Common.id_info_insert_fv uu____9105 fv ty))
in (FStar_ST.op_Colon_Equals env.identifier_info uu____9104)))


let promote_id_info : env  ->  (FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ)  ->  unit = (fun env ty_map -> (

let uu____9167 = (

let uu____9168 = (FStar_ST.op_Bang env.identifier_info)
in (FStar_TypeChecker_Common.id_info_promote uu____9168 ty_map))
in (FStar_ST.op_Colon_Equals env.identifier_info uu____9167)))


let modules : env  ->  FStar_Syntax_Syntax.modul Prims.list = (fun env -> env.modules)


let current_module : env  ->  FStar_Ident.lident = (fun env -> env.curmodule)


let set_current_module : env  ->  FStar_Ident.lident  ->  env = (fun env lid -> (

let uu___96_9237 = env
in {solver = uu___96_9237.solver; range = uu___96_9237.range; curmodule = lid; gamma = uu___96_9237.gamma; gamma_sig = uu___96_9237.gamma_sig; gamma_cache = uu___96_9237.gamma_cache; modules = uu___96_9237.modules; expected_typ = uu___96_9237.expected_typ; sigtab = uu___96_9237.sigtab; is_pattern = uu___96_9237.is_pattern; instantiate_imp = uu___96_9237.instantiate_imp; effects = uu___96_9237.effects; generalize = uu___96_9237.generalize; letrecs = uu___96_9237.letrecs; top_level = uu___96_9237.top_level; check_uvars = uu___96_9237.check_uvars; use_eq = uu___96_9237.use_eq; is_iface = uu___96_9237.is_iface; admit = uu___96_9237.admit; lax = uu___96_9237.lax; lax_universes = uu___96_9237.lax_universes; failhard = uu___96_9237.failhard; nosynth = uu___96_9237.nosynth; tc_term = uu___96_9237.tc_term; type_of = uu___96_9237.type_of; universe_of = uu___96_9237.universe_of; check_type_of = uu___96_9237.check_type_of; use_bv_sorts = uu___96_9237.use_bv_sorts; qtbl_name_and_index = uu___96_9237.qtbl_name_and_index; normalized_eff_names = uu___96_9237.normalized_eff_names; proof_ns = uu___96_9237.proof_ns; synth_hook = uu___96_9237.synth_hook; splice = uu___96_9237.splice; is_native_tactic = uu___96_9237.is_native_tactic; identifier_info = uu___96_9237.identifier_info; tc_hooks = uu___96_9237.tc_hooks; dsenv = uu___96_9237.dsenv; dep_graph = uu___96_9237.dep_graph}))


let has_interface : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (FStar_All.pipe_right env.modules (FStar_Util.for_some (fun m -> (m.FStar_Syntax_Syntax.is_interface && (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name l))))))


let find_in_sigtab : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.sigelt FStar_Pervasives_Native.option = (fun env lid -> (

let uu____9264 = (FStar_Ident.text_of_lid lid)
in (FStar_Util.smap_try_find (sigtab env) uu____9264)))


let name_not_found : FStar_Ident.lid  ->  (FStar_Errors.raw_error * Prims.string) = (fun l -> (

let uu____9274 = (FStar_Util.format1 "Name \"%s\" not found" l.FStar_Ident.str)
in ((FStar_Errors.Fatal_NameNotFound), (uu____9274))))


let variable_not_found : FStar_Syntax_Syntax.bv  ->  (FStar_Errors.raw_error * Prims.string) = (fun v1 -> (

let uu____9284 = (

let uu____9285 = (FStar_Syntax_Print.bv_to_string v1)
in (FStar_Util.format1 "Variable \"%s\" not found" uu____9285))
in ((FStar_Errors.Fatal_VariableNotFound), (uu____9284))))


let new_u_univ : unit  ->  FStar_Syntax_Syntax.universe = (fun uu____9290 -> (

let uu____9291 = (FStar_Syntax_Unionfind.univ_fresh ())
in FStar_Syntax_Syntax.U_unif (uu____9291)))


let inst_tscheme_with : FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.universes  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun ts us -> (match (((ts), (us))) with
| (([], t), []) -> begin
(([]), (t))
end
| ((formals, t), uu____9347) -> begin
(

let n1 = ((FStar_List.length formals) - (Prims.parse_int "1"))
in (

let vs = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> FStar_Syntax_Syntax.UN ((((n1 - i)), (u))))))
in (

let uu____9381 = (FStar_Syntax_Subst.subst vs t)
in ((us), (uu____9381)))))
end))


let inst_tscheme : FStar_Syntax_Syntax.tscheme  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun uu___75_9397 -> (match (uu___75_9397) with
| ([], t) -> begin
(([]), (t))
end
| (us, t) -> begin
(

let us' = (FStar_All.pipe_right us (FStar_List.map (fun uu____9423 -> (new_u_univ ()))))
in (inst_tscheme_with ((us), (t)) us'))
end))


let inst_tscheme_with_range : FStar_Range.range  ->  FStar_Syntax_Syntax.tscheme  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun r t -> (

let uu____9442 = (inst_tscheme t)
in (match (uu____9442) with
| (us, t1) -> begin
(

let uu____9453 = (FStar_Syntax_Subst.set_use_range r t1)
in ((us), (uu____9453)))
end)))


let inst_effect_fun_with : FStar_Syntax_Syntax.universes  ->  env  ->  FStar_Syntax_Syntax.eff_decl  ->  FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.term = (fun insts env ed uu____9473 -> (match (uu____9473) with
| (us, t) -> begin
(match (ed.FStar_Syntax_Syntax.binders) with
| [] -> begin
(

let univs1 = (FStar_List.append ed.FStar_Syntax_Syntax.univs us)
in ((match ((Prims.op_disEquality (FStar_List.length insts) (FStar_List.length univs1))) with
| true -> begin
(

let uu____9492 = (

let uu____9493 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs1))
in (

let uu____9494 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length insts))
in (

let uu____9495 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (

let uu____9496 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format4 "Expected %s instantiations; got %s; failed universe instantiation in effect %s\n\t%s\n" uu____9493 uu____9494 uu____9495 uu____9496)))))
in (failwith uu____9492))
end
| uu____9497 -> begin
()
end);
(

let uu____9498 = (inst_tscheme_with (((FStar_List.append ed.FStar_Syntax_Syntax.univs us)), (t)) insts)
in (FStar_Pervasives_Native.snd uu____9498));
))
end
| uu____9507 -> begin
(

let uu____9508 = (

let uu____9509 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (FStar_Util.format1 "Unexpected use of an uninstantiated effect: %s\n" uu____9509))
in (failwith uu____9508))
end)
end))

type tri =
| Yes
| No
| Maybe


let uu___is_Yes : tri  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Yes -> begin
true
end
| uu____9515 -> begin
false
end))


let uu___is_No : tri  ->  Prims.bool = (fun projectee -> (match (projectee) with
| No -> begin
true
end
| uu____9521 -> begin
false
end))


let uu___is_Maybe : tri  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Maybe -> begin
true
end
| uu____9527 -> begin
false
end))


let in_cur_mod : env  ->  FStar_Ident.lident  ->  tri = (fun env l -> (

let cur = (current_module env)
in (match ((Prims.op_Equality l.FStar_Ident.nsstr cur.FStar_Ident.str)) with
| true -> begin
Yes
end
| uu____9539 -> begin
(match ((FStar_Util.starts_with l.FStar_Ident.nsstr cur.FStar_Ident.str)) with
| true -> begin
(

let lns = (FStar_List.append l.FStar_Ident.ns ((l.FStar_Ident.ident)::[]))
in (

let cur1 = (FStar_List.append cur.FStar_Ident.ns ((cur.FStar_Ident.ident)::[]))
in (

let rec aux = (fun c l1 -> (match (((c), (l1))) with
| ([], uu____9569) -> begin
Maybe
end
| (uu____9576, []) -> begin
No
end
| ((hd1)::tl1, (hd')::tl') when (Prims.op_Equality hd1.FStar_Ident.idText hd'.FStar_Ident.idText) -> begin
(aux tl1 tl')
end
| uu____9595 -> begin
No
end))
in (aux cur1 lns))))
end
| uu____9604 -> begin
No
end)
end)))


type qninfo =
(((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option)) FStar_Util.either * FStar_Range.range) FStar_Pervasives_Native.option


let lookup_qname : env  ->  FStar_Ident.lident  ->  qninfo = (fun env lid -> (

let cur_mod = (in_cur_mod env lid)
in (

let cache = (fun t -> ((FStar_Util.smap_add (gamma_cache env) lid.FStar_Ident.str t);
FStar_Pervasives_Native.Some (t);
))
in (

let found = (match ((Prims.op_disEquality cur_mod No)) with
| true -> begin
(

let uu____9686 = (FStar_Util.smap_try_find (gamma_cache env) lid.FStar_Ident.str)
in (match (uu____9686) with
| FStar_Pervasives_Native.None -> begin
(

let uu____9709 = (FStar_Util.find_map env.gamma (fun uu___76_9753 -> (match (uu___76_9753) with
| FStar_Syntax_Syntax.Binding_lid (l, t) -> begin
(

let uu____9792 = (FStar_Ident.lid_equals lid l)
in (match (uu____9792) with
| true -> begin
(

let uu____9813 = (

let uu____9832 = (

let uu____9847 = (inst_tscheme t)
in FStar_Util.Inl (uu____9847))
in (

let uu____9862 = (FStar_Ident.range_of_lid l)
in ((uu____9832), (uu____9862))))
in FStar_Pervasives_Native.Some (uu____9813))
end
| uu____9895 -> begin
FStar_Pervasives_Native.None
end))
end
| uu____9914 -> begin
FStar_Pervasives_Native.None
end)))
in (FStar_Util.catch_opt uu____9709 (fun uu____9952 -> (FStar_Util.find_map env.gamma_sig (fun uu___77_9961 -> (match (uu___77_9961) with
| (uu____9964, {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_bundle (ses, uu____9966); FStar_Syntax_Syntax.sigrng = uu____9967; FStar_Syntax_Syntax.sigquals = uu____9968; FStar_Syntax_Syntax.sigmeta = uu____9969; FStar_Syntax_Syntax.sigattrs = uu____9970}) -> begin
(FStar_Util.find_map ses (fun se -> (

let uu____9990 = (FStar_All.pipe_right (FStar_Syntax_Util.lids_of_sigelt se) (FStar_Util.for_some (FStar_Ident.lid_equals lid)))
in (match (uu____9990) with
| true -> begin
(cache ((FStar_Util.Inr (((se), (FStar_Pervasives_Native.None)))), ((FStar_Syntax_Util.range_of_sigelt se))))
end
| uu____10021 -> begin
FStar_Pervasives_Native.None
end))))
end
| (lids, s) -> begin
(

let maybe_cache = (fun t -> (match (s.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_declare_typ (uu____10038) -> begin
FStar_Pervasives_Native.Some (t)
end
| uu____10045 -> begin
(cache t)
end))
in (

let uu____10046 = (FStar_List.tryFind (FStar_Ident.lid_equals lid) lids)
in (match (uu____10046) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some (l) -> begin
(

let uu____10052 = (

let uu____10053 = (FStar_Ident.range_of_lid l)
in ((FStar_Util.Inr (((s), (FStar_Pervasives_Native.None)))), (uu____10053)))
in (maybe_cache uu____10052))
end)))
end))))))
end
| se -> begin
se
end))
end
| uu____10083 -> begin
FStar_Pervasives_Native.None
end)
in (match ((FStar_Util.is_some found)) with
| true -> begin
found
end
| uu____10120 -> begin
(

let uu____10121 = (find_in_sigtab env lid)
in (match (uu____10121) with
| FStar_Pervasives_Native.Some (se) -> begin
FStar_Pervasives_Native.Some (((FStar_Util.Inr (((se), (FStar_Pervasives_Native.None)))), ((FStar_Syntax_Util.range_of_sigelt se))))
end
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end))
end)))))


let rec add_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  unit = (fun env se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_bundle (ses, uu____10208) -> begin
(add_sigelts env ses)
end
| uu____10217 -> begin
(

let lids = (FStar_Syntax_Util.lids_of_sigelt se)
in ((FStar_List.iter (fun l -> (FStar_Util.smap_add (sigtab env) l.FStar_Ident.str se)) lids);
(match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_new_effect (ne) -> begin
(FStar_All.pipe_right ne.FStar_Syntax_Syntax.actions (FStar_List.iter (fun a -> (

let se_let = (FStar_Syntax_Util.action_as_lb ne.FStar_Syntax_Syntax.mname a a.FStar_Syntax_Syntax.action_defn.FStar_Syntax_Syntax.pos)
in (FStar_Util.smap_add (sigtab env) a.FStar_Syntax_Syntax.action_name.FStar_Ident.str se_let)))))
end
| uu____10231 -> begin
()
end);
))
end))
and add_sigelts : env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  unit = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.iter (add_sigelt env))))


let try_lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  (FStar_Syntax_Syntax.typ * FStar_Range.range) FStar_Pervasives_Native.option = (fun env bv -> (FStar_Util.find_map env.gamma (fun uu___78_10262 -> (match (uu___78_10262) with
| FStar_Syntax_Syntax.Binding_var (id1) when (FStar_Syntax_Syntax.bv_eq id1 bv) -> begin
FStar_Pervasives_Native.Some (((id1.FStar_Syntax_Syntax.sort), (id1.FStar_Syntax_Syntax.ppname.FStar_Ident.idRange)))
end
| uu____10280 -> begin
FStar_Pervasives_Native.None
end))))


let lookup_type_of_let : FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option  ->  FStar_Syntax_Syntax.sigelt  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) * FStar_Range.range) FStar_Pervasives_Native.option = (fun us_opt se lid -> (

let inst_tscheme1 = (fun ts -> (match (us_opt) with
| FStar_Pervasives_Native.None -> begin
(inst_tscheme ts)
end
| FStar_Pervasives_Native.Some (us) -> begin
(inst_tscheme_with ts us)
end))
in (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_let ((uu____10341, (lb)::[]), uu____10343) -> begin
(

let uu____10350 = (

let uu____10359 = (inst_tscheme1 ((lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp)))
in (

let uu____10368 = (FStar_Syntax_Syntax.range_of_lbname lb.FStar_Syntax_Syntax.lbname)
in ((uu____10359), (uu____10368))))
in FStar_Pervasives_Native.Some (uu____10350))
end
| FStar_Syntax_Syntax.Sig_let ((uu____10381, lbs), uu____10383) -> begin
(FStar_Util.find_map lbs (fun lb -> (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inl (uu____10413) -> begin
(failwith "impossible")
end
| FStar_Util.Inr (fv) -> begin
(

let uu____10425 = (FStar_Syntax_Syntax.fv_eq_lid fv lid)
in (match (uu____10425) with
| true -> begin
(

let uu____10436 = (

let uu____10445 = (inst_tscheme1 ((lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp)))
in (

let uu____10454 = (FStar_Syntax_Syntax.range_of_fv fv)
in ((uu____10445), (uu____10454))))
in FStar_Pervasives_Native.Some (uu____10436))
end
| uu____10467 -> begin
FStar_Pervasives_Native.None
end))
end)))
end
| uu____10476 -> begin
FStar_Pervasives_Native.None
end)))


let effect_signature : FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option  ->  FStar_Syntax_Syntax.sigelt  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) * FStar_Range.range) FStar_Pervasives_Native.option = (fun us_opt se -> (

let inst_tscheme1 = (fun ts -> (match (us_opt) with
| FStar_Pervasives_Native.None -> begin
(inst_tscheme ts)
end
| FStar_Pervasives_Native.Some (us) -> begin
(inst_tscheme_with ts us)
end))
in (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_new_effect (ne) -> begin
(

let uu____10535 = (

let uu____10544 = (

let uu____10549 = (

let uu____10550 = (

let uu____10553 = (FStar_Syntax_Syntax.mk_Total ne.FStar_Syntax_Syntax.signature)
in (FStar_Syntax_Util.arrow ne.FStar_Syntax_Syntax.binders uu____10553))
in ((ne.FStar_Syntax_Syntax.univs), (uu____10550)))
in (inst_tscheme1 uu____10549))
in ((uu____10544), (se.FStar_Syntax_Syntax.sigrng)))
in FStar_Pervasives_Native.Some (uu____10535))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (lid, us, binders, uu____10575, uu____10576) -> begin
(

let uu____10581 = (

let uu____10590 = (

let uu____10595 = (

let uu____10596 = (

let uu____10599 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Syntax.teff)
in (FStar_Syntax_Util.arrow binders uu____10599))
in ((us), (uu____10596)))
in (inst_tscheme1 uu____10595))
in ((uu____10590), (se.FStar_Syntax_Syntax.sigrng)))
in FStar_Pervasives_Native.Some (uu____10581))
end
| uu____10618 -> begin
FStar_Pervasives_Native.None
end)))


let try_lookup_lid_aux : FStar_Syntax_Syntax.universes FStar_Pervasives_Native.option  ->  env  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) * FStar_Range.range) FStar_Pervasives_Native.option = (fun us_opt env lid -> (

let inst_tscheme1 = (fun ts -> (match (us_opt) with
| FStar_Pervasives_Native.None -> begin
(inst_tscheme ts)
end
| FStar_Pervasives_Native.Some (us) -> begin
(inst_tscheme_with ts us)
end))
in (

let mapper = (fun uu____10706 -> (match (uu____10706) with
| (lr, rng) -> begin
(match (lr) with
| FStar_Util.Inl (t) -> begin
FStar_Pervasives_Native.Some (((t), (rng)))
end
| FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (uu____10802, uvs, t, uu____10805, uu____10806, uu____10807); FStar_Syntax_Syntax.sigrng = uu____10808; FStar_Syntax_Syntax.sigquals = uu____10809; FStar_Syntax_Syntax.sigmeta = uu____10810; FStar_Syntax_Syntax.sigattrs = uu____10811}, FStar_Pervasives_Native.None) -> begin
(

let uu____10832 = (

let uu____10841 = (inst_tscheme1 ((uvs), (t)))
in ((uu____10841), (rng)))
in FStar_Pervasives_Native.Some (uu____10832))
end
| FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (l, uvs, t); FStar_Syntax_Syntax.sigrng = uu____10865; FStar_Syntax_Syntax.sigquals = qs; FStar_Syntax_Syntax.sigmeta = uu____10867; FStar_Syntax_Syntax.sigattrs = uu____10868}, FStar_Pervasives_Native.None) -> begin
(

let uu____10885 = (

let uu____10886 = (in_cur_mod env l)
in (Prims.op_Equality uu____10886 Yes))
in (match (uu____10885) with
| true -> begin
(

let uu____10897 = ((FStar_All.pipe_right qs (FStar_List.contains FStar_Syntax_Syntax.Assumption)) || env.is_iface)
in (match (uu____10897) with
| true -> begin
(

let uu____10910 = (

let uu____10919 = (inst_tscheme1 ((uvs), (t)))
in ((uu____10919), (rng)))
in FStar_Pervasives_Native.Some (uu____10910))
end
| uu____10940 -> begin
FStar_Pervasives_Native.None
end))
end
| uu____10949 -> begin
(

let uu____10950 = (

let uu____10959 = (inst_tscheme1 ((uvs), (t)))
in ((uu____10959), (rng)))
in FStar_Pervasives_Native.Some (uu____10950))
end))
end
| FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (lid1, uvs, tps, k, uu____10984, uu____10985); FStar_Syntax_Syntax.sigrng = uu____10986; FStar_Syntax_Syntax.sigquals = uu____10987; FStar_Syntax_Syntax.sigmeta = uu____10988; FStar_Syntax_Syntax.sigattrs = uu____10989}, FStar_Pervasives_Native.None) -> begin
(match (tps) with
| [] -> begin
(

let uu____11028 = (

let uu____11037 = (inst_tscheme1 ((uvs), (k)))
in ((uu____11037), (rng)))
in FStar_Pervasives_Native.Some (uu____11028))
end
| uu____11058 -> begin
(

let uu____11059 = (

let uu____11068 = (

let uu____11073 = (

let uu____11074 = (

let uu____11077 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.flat_arrow tps uu____11077))
in ((uvs), (uu____11074)))
in (inst_tscheme1 uu____11073))
in ((uu____11068), (rng)))
in FStar_Pervasives_Native.Some (uu____11059))
end)
end
| FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (lid1, uvs, tps, k, uu____11100, uu____11101); FStar_Syntax_Syntax.sigrng = uu____11102; FStar_Syntax_Syntax.sigquals = uu____11103; FStar_Syntax_Syntax.sigmeta = uu____11104; FStar_Syntax_Syntax.sigattrs = uu____11105}, FStar_Pervasives_Native.Some (us)) -> begin
(match (tps) with
| [] -> begin
(

let uu____11145 = (

let uu____11154 = (inst_tscheme_with ((uvs), (k)) us)
in ((uu____11154), (rng)))
in FStar_Pervasives_Native.Some (uu____11145))
end
| uu____11175 -> begin
(

let uu____11176 = (

let uu____11185 = (

let uu____11190 = (

let uu____11191 = (

let uu____11194 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.flat_arrow tps uu____11194))
in ((uvs), (uu____11191)))
in (inst_tscheme_with uu____11190 us))
in ((uu____11185), (rng)))
in FStar_Pervasives_Native.Some (uu____11176))
end)
end
| FStar_Util.Inr (se) -> begin
(

let uu____11230 = (match (se) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_let (uu____11251); FStar_Syntax_Syntax.sigrng = uu____11252; FStar_Syntax_Syntax.sigquals = uu____11253; FStar_Syntax_Syntax.sigmeta = uu____11254; FStar_Syntax_Syntax.sigattrs = uu____11255}, FStar_Pervasives_Native.None) -> begin
(lookup_type_of_let us_opt (FStar_Pervasives_Native.fst se) lid)
end
| uu____11270 -> begin
(effect_signature us_opt (FStar_Pervasives_Native.fst se))
end)
in (FStar_All.pipe_right uu____11230 (FStar_Util.map_option (fun uu____11318 -> (match (uu____11318) with
| (us_t, rng1) -> begin
((us_t), (rng1))
end)))))
end)
end))
in (

let uu____11349 = (

let uu____11360 = (lookup_qname env lid)
in (FStar_Util.bind_opt uu____11360 mapper))
in (match (uu____11349) with
| FStar_Pervasives_Native.Some ((us, t), r) -> begin
(

let uu____11434 = (

let uu____11445 = (

let uu____11452 = (

let uu___97_11455 = t
in (

let uu____11456 = (FStar_Ident.range_of_lid lid)
in {FStar_Syntax_Syntax.n = uu___97_11455.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.pos = uu____11456; FStar_Syntax_Syntax.vars = uu___97_11455.FStar_Syntax_Syntax.vars}))
in ((us), (uu____11452)))
in ((uu____11445), (r)))
in FStar_Pervasives_Native.Some (uu____11434))
end
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end)))))


let lid_exists : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (

let uu____11503 = (lookup_qname env l)
in (match (uu____11503) with
| FStar_Pervasives_Native.None -> begin
false
end
| FStar_Pervasives_Native.Some (uu____11522) -> begin
true
end)))


let lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  (FStar_Syntax_Syntax.typ * FStar_Range.range) = (fun env bv -> (

let bvr = (FStar_Syntax_Syntax.range_of_bv bv)
in (

let uu____11574 = (try_lookup_bv env bv)
in (match (uu____11574) with
| FStar_Pervasives_Native.None -> begin
(

let uu____11589 = (variable_not_found bv)
in (FStar_Errors.raise_error uu____11589 bvr))
end
| FStar_Pervasives_Native.Some (t, r) -> begin
(

let uu____11604 = (FStar_Syntax_Subst.set_use_range bvr t)
in (

let uu____11605 = (

let uu____11606 = (FStar_Range.use_range bvr)
in (FStar_Range.set_use_range r uu____11606))
in ((uu____11604), (uu____11605))))
end))))


let try_lookup_lid : env  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) * FStar_Range.range) FStar_Pervasives_Native.option = (fun env l -> (

let uu____11627 = (try_lookup_lid_aux FStar_Pervasives_Native.None env l)
in (match (uu____11627) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some ((us, t), r) -> begin
(

let use_range1 = (FStar_Ident.range_of_lid l)
in (

let r1 = (

let uu____11693 = (FStar_Range.use_range use_range1)
in (FStar_Range.set_use_range r uu____11693))
in (

let uu____11694 = (

let uu____11703 = (

let uu____11708 = (FStar_Syntax_Subst.set_use_range use_range1 t)
in ((us), (uu____11708)))
in ((uu____11703), (r1)))
in FStar_Pervasives_Native.Some (uu____11694))))
end)))


let try_lookup_and_inst_lid : env  ->  FStar_Syntax_Syntax.universes  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.typ * FStar_Range.range) FStar_Pervasives_Native.option = (fun env us l -> (

let uu____11742 = (try_lookup_lid_aux (FStar_Pervasives_Native.Some (us)) env l)
in (match (uu____11742) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some ((uu____11775, t), r) -> begin
(

let use_range1 = (FStar_Ident.range_of_lid l)
in (

let r1 = (

let uu____11800 = (FStar_Range.use_range use_range1)
in (FStar_Range.set_use_range r uu____11800))
in (

let uu____11801 = (

let uu____11806 = (FStar_Syntax_Subst.set_use_range use_range1 t)
in ((uu____11806), (r1)))
in FStar_Pervasives_Native.Some (uu____11801))))
end)))


let lookup_lid : env  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) * FStar_Range.range) = (fun env l -> (

let uu____11829 = (try_lookup_lid env l)
in (match (uu____11829) with
| FStar_Pervasives_Native.None -> begin
(

let uu____11856 = (name_not_found l)
in (

let uu____11861 = (FStar_Ident.range_of_lid l)
in (FStar_Errors.raise_error uu____11856 uu____11861)))
end
| FStar_Pervasives_Native.Some (v1) -> begin
v1
end)))


let lookup_univ : env  ->  FStar_Syntax_Syntax.univ_name  ->  Prims.bool = (fun env x -> (FStar_All.pipe_right (FStar_List.find (fun uu___79_11901 -> (match (uu___79_11901) with
| FStar_Syntax_Syntax.Binding_univ (y) -> begin
(Prims.op_Equality x.FStar_Ident.idText y.FStar_Ident.idText)
end
| uu____11903 -> begin
false
end)) env.gamma) FStar_Option.isSome))


let try_lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.tscheme * FStar_Syntax_Syntax.qualifier Prims.list) FStar_Pervasives_Native.option = (fun env lid -> (

let uu____11922 = (lookup_qname env lid)
in (match (uu____11922) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (uu____11931, uvs, t); FStar_Syntax_Syntax.sigrng = uu____11934; FStar_Syntax_Syntax.sigquals = q; FStar_Syntax_Syntax.sigmeta = uu____11936; FStar_Syntax_Syntax.sigattrs = uu____11937}, FStar_Pervasives_Native.None), uu____11938) -> begin
(

let uu____11987 = (

let uu____11994 = (

let uu____11995 = (

let uu____11998 = (FStar_Ident.range_of_lid lid)
in (FStar_Syntax_Subst.set_use_range uu____11998 t))
in ((uvs), (uu____11995)))
in ((uu____11994), (q)))
in FStar_Pervasives_Native.Some (uu____11987))
end
| uu____12011 -> begin
FStar_Pervasives_Native.None
end)))


let lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (

let uu____12032 = (lookup_qname env lid)
in (match (uu____12032) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (uu____12037, uvs, t); FStar_Syntax_Syntax.sigrng = uu____12040; FStar_Syntax_Syntax.sigquals = uu____12041; FStar_Syntax_Syntax.sigmeta = uu____12042; FStar_Syntax_Syntax.sigattrs = uu____12043}, FStar_Pervasives_Native.None), uu____12044) -> begin
(

let uu____12093 = (FStar_Ident.range_of_lid lid)
in (inst_tscheme_with_range uu____12093 ((uvs), (t))))
end
| uu____12098 -> begin
(

let uu____12099 = (name_not_found lid)
in (

let uu____12104 = (FStar_Ident.range_of_lid lid)
in (FStar_Errors.raise_error uu____12099 uu____12104)))
end)))


let lookup_datacon : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (

let uu____12123 = (lookup_qname env lid)
in (match (uu____12123) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (uu____12128, uvs, t, uu____12131, uu____12132, uu____12133); FStar_Syntax_Syntax.sigrng = uu____12134; FStar_Syntax_Syntax.sigquals = uu____12135; FStar_Syntax_Syntax.sigmeta = uu____12136; FStar_Syntax_Syntax.sigattrs = uu____12137}, FStar_Pervasives_Native.None), uu____12138) -> begin
(

let uu____12191 = (FStar_Ident.range_of_lid lid)
in (inst_tscheme_with_range uu____12191 ((uvs), (t))))
end
| uu____12196 -> begin
(

let uu____12197 = (name_not_found lid)
in (

let uu____12202 = (FStar_Ident.range_of_lid lid)
in (FStar_Errors.raise_error uu____12197 uu____12202)))
end)))


let datacons_of_typ : env  ->  FStar_Ident.lident  ->  (Prims.bool * FStar_Ident.lident Prims.list) = (fun env lid -> (

let uu____12223 = (lookup_qname env lid)
in (match (uu____12223) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (uu____12230, uu____12231, uu____12232, uu____12233, uu____12234, dcs); FStar_Syntax_Syntax.sigrng = uu____12236; FStar_Syntax_Syntax.sigquals = uu____12237; FStar_Syntax_Syntax.sigmeta = uu____12238; FStar_Syntax_Syntax.sigattrs = uu____12239}, uu____12240), uu____12241) -> begin
((true), (dcs))
end
| uu____12302 -> begin
((false), ([]))
end)))


let typ_of_datacon : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env lid -> (

let uu____12315 = (lookup_qname env lid)
in (match (uu____12315) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (uu____12316, uu____12317, uu____12318, l, uu____12320, uu____12321); FStar_Syntax_Syntax.sigrng = uu____12322; FStar_Syntax_Syntax.sigquals = uu____12323; FStar_Syntax_Syntax.sigmeta = uu____12324; FStar_Syntax_Syntax.sigattrs = uu____12325}, uu____12326), uu____12327) -> begin
l
end
| uu____12382 -> begin
(

let uu____12383 = (

let uu____12384 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format1 "Not a datacon: %s" uu____12384))
in (failwith uu____12383))
end)))


let lookup_definition_qninfo : delta_level Prims.list  ->  FStar_Ident.lident  ->  qninfo  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term) FStar_Pervasives_Native.option = (fun delta_levels lid qninfo -> (

let visible = (fun quals -> (FStar_All.pipe_right delta_levels (FStar_Util.for_some (fun dl -> (FStar_All.pipe_right quals (FStar_Util.for_some (visible_at dl)))))))
in (match (qninfo) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr (se, FStar_Pervasives_Native.None), uu____12433) -> begin
(match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_let ((uu____12484, lbs), uu____12486) when (visible se.FStar_Syntax_Syntax.sigquals) -> begin
(FStar_Util.find_map lbs (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let uu____12508 = (FStar_Syntax_Syntax.fv_eq_lid fv lid)
in (match (uu____12508) with
| true -> begin
FStar_Pervasives_Native.Some (((lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbdef)))
end
| uu____12531 -> begin
FStar_Pervasives_Native.None
end)))))
end
| uu____12540 -> begin
FStar_Pervasives_Native.None
end)
end
| uu____12545 -> begin
FStar_Pervasives_Native.None
end)))


let lookup_definition : delta_level Prims.list  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term) FStar_Pervasives_Native.option = (fun delta_levels env lid -> (

let uu____12575 = (lookup_qname env lid)
in (FStar_All.pipe_left (lookup_definition_qninfo delta_levels lid) uu____12575)))


let attrs_of_qninfo : qninfo  ->  FStar_Syntax_Syntax.attribute Prims.list FStar_Pervasives_Native.option = (fun qninfo -> (match (qninfo) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr (se, uu____12600), uu____12601) -> begin
FStar_Pervasives_Native.Some (se.FStar_Syntax_Syntax.sigattrs)
end
| uu____12650 -> begin
FStar_Pervasives_Native.None
end))


let lookup_attrs_of_lid : env  ->  FStar_Ident.lid  ->  FStar_Syntax_Syntax.attribute Prims.list FStar_Pervasives_Native.option = (fun env lid -> (

let uu____12671 = (lookup_qname env lid)
in (FStar_All.pipe_left attrs_of_qninfo uu____12671)))


let try_lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term FStar_Pervasives_Native.option = (fun env ftv -> (

let uu____12690 = (lookup_qname env ftv)
in (match (uu____12690) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr (se, FStar_Pervasives_Native.None), uu____12694) -> begin
(

let uu____12739 = (effect_signature FStar_Pervasives_Native.None se)
in (match (uu____12739) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some ((uu____12760, t), r) -> begin
(

let uu____12775 = (

let uu____12776 = (FStar_Ident.range_of_lid ftv)
in (FStar_Syntax_Subst.set_use_range uu____12776 t))
in FStar_Pervasives_Native.Some (uu____12775))
end))
end
| uu____12777 -> begin
FStar_Pervasives_Native.None
end)))


let lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term = (fun env ftv -> (

let uu____12788 = (try_lookup_effect_lid env ftv)
in (match (uu____12788) with
| FStar_Pervasives_Native.None -> begin
(

let uu____12791 = (name_not_found ftv)
in (

let uu____12796 = (FStar_Ident.range_of_lid ftv)
in (FStar_Errors.raise_error uu____12791 uu____12796)))
end
| FStar_Pervasives_Native.Some (k) -> begin
k
end)))


let lookup_effect_abbrev : env  ->  FStar_Syntax_Syntax.universes  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) FStar_Pervasives_Native.option = (fun env univ_insts lid0 -> (

let uu____12819 = (lookup_qname env lid0)
in (match (uu____12819) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_effect_abbrev (lid, univs1, binders, c, uu____12830); FStar_Syntax_Syntax.sigrng = uu____12831; FStar_Syntax_Syntax.sigquals = quals; FStar_Syntax_Syntax.sigmeta = uu____12833; FStar_Syntax_Syntax.sigattrs = uu____12834}, FStar_Pervasives_Native.None), uu____12835) -> begin
(

let lid1 = (

let uu____12889 = (

let uu____12890 = (FStar_Ident.range_of_lid lid)
in (

let uu____12891 = (

let uu____12892 = (FStar_Ident.range_of_lid lid0)
in (FStar_Range.use_range uu____12892))
in (FStar_Range.set_use_range uu____12890 uu____12891)))
in (FStar_Ident.set_lid_range lid uu____12889))
in (

let uu____12893 = (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___80_12897 -> (match (uu___80_12897) with
| FStar_Syntax_Syntax.Irreducible -> begin
true
end
| uu____12898 -> begin
false
end))))
in (match (uu____12893) with
| true -> begin
FStar_Pervasives_Native.None
end
| uu____12909 -> begin
(

let insts = (match ((Prims.op_Equality (FStar_List.length univ_insts) (FStar_List.length univs1))) with
| true -> begin
univ_insts
end
| uu____12911 -> begin
(

let uu____12912 = (

let uu____12913 = (

let uu____12914 = (get_range env)
in (FStar_Range.string_of_range uu____12914))
in (

let uu____12915 = (FStar_Syntax_Print.lid_to_string lid1)
in (

let uu____12916 = (FStar_All.pipe_right (FStar_List.length univ_insts) FStar_Util.string_of_int)
in (FStar_Util.format3 "(%s) Unexpected instantiation of effect %s with %s universes" uu____12913 uu____12915 uu____12916))))
in (failwith uu____12912))
end)
in (match (((binders), (univs1))) with
| ([], uu____12931) -> begin
(failwith "Unexpected effect abbreviation with no arguments")
end
| (uu____12952, (uu____12953)::(uu____12954)::uu____12955) -> begin
(

let uu____12972 = (

let uu____12973 = (FStar_Syntax_Print.lid_to_string lid1)
in (

let uu____12974 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs1))
in (FStar_Util.format2 "Unexpected effect abbreviation %s; polymorphic in %s universes" uu____12973 uu____12974)))
in (failwith uu____12972))
end
| uu____12981 -> begin
(

let uu____12994 = (

let uu____12999 = (

let uu____13000 = (FStar_Syntax_Util.arrow binders c)
in ((univs1), (uu____13000)))
in (inst_tscheme_with uu____12999 insts))
in (match (uu____12994) with
| (uu____13013, t) -> begin
(

let t1 = (

let uu____13016 = (FStar_Ident.range_of_lid lid1)
in (FStar_Syntax_Subst.set_use_range uu____13016 t))
in (

let uu____13017 = (

let uu____13018 = (FStar_Syntax_Subst.compress t1)
in uu____13018.FStar_Syntax_Syntax.n)
in (match (uu____13017) with
| FStar_Syntax_Syntax.Tm_arrow (binders1, c1) -> begin
FStar_Pervasives_Native.Some (((binders1), (c1)))
end
| uu____13049 -> begin
(failwith "Impossible")
end)))
end))
end))
end)))
end
| uu____13056 -> begin
FStar_Pervasives_Native.None
end)))


let norm_eff_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env l -> (

let rec find1 = (fun l1 -> (

let uu____13079 = (lookup_effect_abbrev env ((FStar_Syntax_Syntax.U_unknown)::[]) l1)
in (match (uu____13079) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some (uu____13092, c) -> begin
(

let l2 = (FStar_Syntax_Util.comp_effect_name c)
in (

let uu____13099 = (find1 l2)
in (match (uu____13099) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.Some (l2)
end
| FStar_Pervasives_Native.Some (l') -> begin
FStar_Pervasives_Native.Some (l')
end)))
end)))
in (

let res = (

let uu____13106 = (FStar_Util.smap_try_find env.normalized_eff_names l.FStar_Ident.str)
in (match (uu____13106) with
| FStar_Pervasives_Native.Some (l1) -> begin
l1
end
| FStar_Pervasives_Native.None -> begin
(

let uu____13110 = (find1 l)
in (match (uu____13110) with
| FStar_Pervasives_Native.None -> begin
l
end
| FStar_Pervasives_Native.Some (m) -> begin
((FStar_Util.smap_add env.normalized_eff_names l.FStar_Ident.str m);
m;
)
end))
end))
in (

let uu____13115 = (FStar_Ident.range_of_lid l)
in (FStar_Ident.set_lid_range res uu____13115)))))


let lookup_effect_quals : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.qualifier Prims.list = (fun env l -> (

let l1 = (norm_eff_name env l)
in (

let uu____13129 = (lookup_qname env l1)
in (match (uu____13129) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect (uu____13132); FStar_Syntax_Syntax.sigrng = uu____13133; FStar_Syntax_Syntax.sigquals = q; FStar_Syntax_Syntax.sigmeta = uu____13135; FStar_Syntax_Syntax.sigattrs = uu____13136}, uu____13137), uu____13138) -> begin
q
end
| uu____13189 -> begin
[]
end))))


let lookup_projector : env  ->  FStar_Ident.lident  ->  Prims.int  ->  FStar_Ident.lident = (fun env lid i -> (

let fail1 = (fun uu____13210 -> (

let uu____13211 = (

let uu____13212 = (FStar_Util.string_of_int i)
in (

let uu____13213 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format2 "Impossible: projecting field #%s from constructor %s is undefined" uu____13212 uu____13213)))
in (failwith uu____13211)))
in (

let uu____13214 = (lookup_datacon env lid)
in (match (uu____13214) with
| (uu____13219, t) -> begin
(

let uu____13221 = (

let uu____13222 = (FStar_Syntax_Subst.compress t)
in uu____13222.FStar_Syntax_Syntax.n)
in (match (uu____13221) with
| FStar_Syntax_Syntax.Tm_arrow (binders, uu____13226) -> begin
(match (((i < (Prims.parse_int "0")) || (i >= (FStar_List.length binders)))) with
| true -> begin
(fail1 ())
end
| uu____13247 -> begin
(

let b = (FStar_List.nth binders i)
in (

let uu____13257 = (FStar_Syntax_Util.mk_field_projector_name lid (FStar_Pervasives_Native.fst b) i)
in (FStar_All.pipe_right uu____13257 FStar_Pervasives_Native.fst)))
end)
end
| uu____13266 -> begin
(fail1 ())
end))
end))))


let is_projector : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (

let uu____13277 = (lookup_qname env l)
in (match (uu____13277) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (uu____13278, uu____13279, uu____13280); FStar_Syntax_Syntax.sigrng = uu____13281; FStar_Syntax_Syntax.sigquals = quals; FStar_Syntax_Syntax.sigmeta = uu____13283; FStar_Syntax_Syntax.sigattrs = uu____13284}, uu____13285), uu____13286) -> begin
(FStar_Util.for_some (fun uu___81_13339 -> (match (uu___81_13339) with
| FStar_Syntax_Syntax.Projector (uu____13340) -> begin
true
end
| uu____13345 -> begin
false
end)) quals)
end
| uu____13346 -> begin
false
end)))


let is_datacon : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____13357 = (lookup_qname env lid)
in (match (uu____13357) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (uu____13358, uu____13359, uu____13360, uu____13361, uu____13362, uu____13363); FStar_Syntax_Syntax.sigrng = uu____13364; FStar_Syntax_Syntax.sigquals = uu____13365; FStar_Syntax_Syntax.sigmeta = uu____13366; FStar_Syntax_Syntax.sigattrs = uu____13367}, uu____13368), uu____13369) -> begin
true
end
| uu____13424 -> begin
false
end)))


let is_record : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____13435 = (lookup_qname env lid)
in (match (uu____13435) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (uu____13436, uu____13437, uu____13438, uu____13439, uu____13440, uu____13441); FStar_Syntax_Syntax.sigrng = uu____13442; FStar_Syntax_Syntax.sigquals = quals; FStar_Syntax_Syntax.sigmeta = uu____13444; FStar_Syntax_Syntax.sigattrs = uu____13445}, uu____13446), uu____13447) -> begin
(FStar_Util.for_some (fun uu___82_13508 -> (match (uu___82_13508) with
| FStar_Syntax_Syntax.RecordType (uu____13509) -> begin
true
end
| FStar_Syntax_Syntax.RecordConstructor (uu____13518) -> begin
true
end
| uu____13527 -> begin
false
end)) quals)
end
| uu____13528 -> begin
false
end)))


let qninfo_is_action : qninfo  ->  Prims.bool = (fun qninfo -> (match (qninfo) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_let (uu____13534, uu____13535); FStar_Syntax_Syntax.sigrng = uu____13536; FStar_Syntax_Syntax.sigquals = quals; FStar_Syntax_Syntax.sigmeta = uu____13538; FStar_Syntax_Syntax.sigattrs = uu____13539}, uu____13540), uu____13541) -> begin
(FStar_Util.for_some (fun uu___83_13598 -> (match (uu___83_13598) with
| FStar_Syntax_Syntax.Action (uu____13599) -> begin
true
end
| uu____13600 -> begin
false
end)) quals)
end
| uu____13601 -> begin
false
end))


let is_action : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____13612 = (lookup_qname env lid)
in (FStar_All.pipe_left qninfo_is_action uu____13612)))


let is_interpreted : env  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (

let interpreted_symbols = (FStar_Parser_Const.op_Eq)::(FStar_Parser_Const.op_notEq)::(FStar_Parser_Const.op_LT)::(FStar_Parser_Const.op_LTE)::(FStar_Parser_Const.op_GT)::(FStar_Parser_Const.op_GTE)::(FStar_Parser_Const.op_Subtraction)::(FStar_Parser_Const.op_Minus)::(FStar_Parser_Const.op_Addition)::(FStar_Parser_Const.op_Multiply)::(FStar_Parser_Const.op_Division)::(FStar_Parser_Const.op_Modulus)::(FStar_Parser_Const.op_And)::(FStar_Parser_Const.op_Or)::(FStar_Parser_Const.op_Negation)::[]
in (fun env head1 -> (

let uu____13626 = (

let uu____13627 = (FStar_Syntax_Util.un_uinst head1)
in uu____13627.FStar_Syntax_Syntax.n)
in (match (uu____13626) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(Prims.op_Equality fv.FStar_Syntax_Syntax.fv_delta FStar_Syntax_Syntax.Delta_equational)
end
| uu____13631 -> begin
false
end))))


let is_irreducible : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (

let uu____13642 = (lookup_qname env l)
in (match (uu____13642) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr (se, uu____13644), uu____13645) -> begin
(FStar_Util.for_some (fun uu___84_13693 -> (match (uu___84_13693) with
| FStar_Syntax_Syntax.Irreducible -> begin
true
end
| uu____13694 -> begin
false
end)) se.FStar_Syntax_Syntax.sigquals)
end
| uu____13695 -> begin
false
end)))


let is_type_constructor : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let mapper = (fun x -> (match ((FStar_Pervasives_Native.fst x)) with
| FStar_Util.Inl (uu____13766) -> begin
FStar_Pervasives_Native.Some (false)
end
| FStar_Util.Inr (se, uu____13782) -> begin
(match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_declare_typ (uu____13799) -> begin
FStar_Pervasives_Native.Some ((FStar_List.contains FStar_Syntax_Syntax.New se.FStar_Syntax_Syntax.sigquals))
end
| FStar_Syntax_Syntax.Sig_inductive_typ (uu____13806) -> begin
FStar_Pervasives_Native.Some (true)
end
| uu____13823 -> begin
FStar_Pervasives_Native.Some (false)
end)
end))
in (

let uu____13824 = (

let uu____13827 = (lookup_qname env lid)
in (FStar_Util.bind_opt uu____13827 mapper))
in (match (uu____13824) with
| FStar_Pervasives_Native.Some (b) -> begin
b
end
| FStar_Pervasives_Native.None -> begin
false
end))))


let num_inductive_ty_params : env  ->  FStar_Ident.lident  ->  Prims.int = (fun env lid -> (

let uu____13877 = (lookup_qname env lid)
in (match (uu____13877) with
| FStar_Pervasives_Native.Some (FStar_Util.Inr ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (uu____13878, uu____13879, tps, uu____13881, uu____13882, uu____13883); FStar_Syntax_Syntax.sigrng = uu____13884; FStar_Syntax_Syntax.sigquals = uu____13885; FStar_Syntax_Syntax.sigmeta = uu____13886; FStar_Syntax_Syntax.sigattrs = uu____13887}, uu____13888), uu____13889) -> begin
(FStar_List.length tps)
end
| uu____13952 -> begin
(

let uu____13953 = (name_not_found lid)
in (

let uu____13958 = (FStar_Ident.range_of_lid lid)
in (FStar_Errors.raise_error uu____13953 uu____13958)))
end)))


let effect_decl_opt : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.eff_decl * FStar_Syntax_Syntax.qualifier Prims.list) FStar_Pervasives_Native.option = (fun env l -> (FStar_All.pipe_right env.effects.decls (FStar_Util.find_opt (fun uu____14002 -> (match (uu____14002) with
| (d, uu____14010) -> begin
(FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname l)
end)))))


let get_effect_decl : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl = (fun env l -> (

let uu____14025 = (effect_decl_opt env l)
in (match (uu____14025) with
| FStar_Pervasives_Native.None -> begin
(

let uu____14040 = (name_not_found l)
in (

let uu____14045 = (FStar_Ident.range_of_lid l)
in (FStar_Errors.raise_error uu____14040 uu____14045)))
end
| FStar_Pervasives_Native.Some (md) -> begin
(FStar_Pervasives_Native.fst md)
end)))


let identity_mlift : mlift = {mlift_wp = (fun uu____14067 t wp -> wp); mlift_term = FStar_Pervasives_Native.Some ((fun uu____14086 t wp e -> (FStar_Util.return_all e)))}


let join : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * mlift * mlift) = (fun env l1 l2 -> (

let uu____14117 = (FStar_Ident.lid_equals l1 l2)
in (match (uu____14117) with
| true -> begin
((l1), (identity_mlift), (identity_mlift))
end
| uu____14124 -> begin
(

let uu____14125 = (((FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_Tot_lid)) || ((FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_Tot_lid)))
in (match (uu____14125) with
| true -> begin
((FStar_Parser_Const.effect_GTot_lid), (identity_mlift), (identity_mlift))
end
| uu____14132 -> begin
(

let uu____14133 = (FStar_All.pipe_right env.effects.joins (FStar_Util.find_opt (fun uu____14186 -> (match (uu____14186) with
| (m1, m2, uu____14199, uu____14200, uu____14201) -> begin
((FStar_Ident.lid_equals l1 m1) && (FStar_Ident.lid_equals l2 m2))
end))))
in (match (uu____14133) with
| FStar_Pervasives_Native.None -> begin
(

let uu____14218 = (

let uu____14223 = (

let uu____14224 = (FStar_Syntax_Print.lid_to_string l1)
in (

let uu____14225 = (FStar_Syntax_Print.lid_to_string l2)
in (FStar_Util.format2 "Effects %s and %s cannot be composed" uu____14224 uu____14225)))
in ((FStar_Errors.Fatal_EffectsCannotBeComposed), (uu____14223)))
in (FStar_Errors.raise_error uu____14218 env.range))
end
| FStar_Pervasives_Native.Some (uu____14232, uu____14233, m3, j1, j2) -> begin
((m3), (j1), (j2))
end))
end))
end)))


let monad_leq : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  edge FStar_Pervasives_Native.option = (fun env l1 l2 -> (

let uu____14266 = ((FStar_Ident.lid_equals l1 l2) || ((FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_Tot_lid) && (FStar_Ident.lid_equals l2 FStar_Parser_Const.effect_GTot_lid)))
in (match (uu____14266) with
| true -> begin
FStar_Pervasives_Native.Some ({msource = l1; mtarget = l2; mlift = identity_mlift})
end
| uu____14269 -> begin
(FStar_All.pipe_right env.effects.order (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals l1 e.msource) && (FStar_Ident.lid_equals l2 e.mtarget)))))
end)))


let wp_sig_aux : 'Auu____14282 . (FStar_Syntax_Syntax.eff_decl * 'Auu____14282) Prims.list  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) = (fun decls m -> (

let uu____14311 = (FStar_All.pipe_right decls (FStar_Util.find_opt (fun uu____14337 -> (match (uu____14337) with
| (d, uu____14343) -> begin
(FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname m)
end))))
in (match (uu____14311) with
| FStar_Pervasives_Native.None -> begin
(

let uu____14354 = (FStar_Util.format1 "Impossible: declaration for monad %s not found" m.FStar_Ident.str)
in (failwith uu____14354))
end
| FStar_Pervasives_Native.Some (md, _q) -> begin
(

let uu____14367 = (inst_tscheme ((md.FStar_Syntax_Syntax.univs), (md.FStar_Syntax_Syntax.signature)))
in (match (uu____14367) with
| (uu____14382, s) -> begin
(

let s1 = (FStar_Syntax_Subst.compress s)
in (match (((md.FStar_Syntax_Syntax.binders), (s1.FStar_Syntax_Syntax.n))) with
| ([], FStar_Syntax_Syntax.Tm_arrow (((a, uu____14398))::((wp, uu____14400))::[], c)) when (FStar_Syntax_Syntax.is_teff (FStar_Syntax_Util.comp_result c)) -> begin
((a), (wp.FStar_Syntax_Syntax.sort))
end
| uu____14436 -> begin
(failwith "Impossible")
end))
end))
end)))


let wp_signature : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env m -> (wp_sig_aux env.effects.decls m))


let null_wp_for_eff : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.comp = (fun env eff_name res_u res_t -> (

let uu____14489 = (FStar_Ident.lid_equals eff_name FStar_Parser_Const.effect_Tot_lid)
in (match (uu____14489) with
| true -> begin
(FStar_Syntax_Syntax.mk_Total' res_t (FStar_Pervasives_Native.Some (res_u)))
end
| uu____14490 -> begin
(

let uu____14491 = (FStar_Ident.lid_equals eff_name FStar_Parser_Const.effect_GTot_lid)
in (match (uu____14491) with
| true -> begin
(FStar_Syntax_Syntax.mk_GTotal' res_t (FStar_Pervasives_Native.Some (res_u)))
end
| uu____14492 -> begin
(

let eff_name1 = (norm_eff_name env eff_name)
in (

let ed = (get_effect_decl env eff_name1)
in (

let null_wp = (inst_effect_fun_with ((res_u)::[]) env ed ed.FStar_Syntax_Syntax.null_wp)
in (

let null_wp_res = (

let uu____14499 = (get_range env)
in (

let uu____14500 = (

let uu____14507 = (

let uu____14508 = (

let uu____14523 = (

let uu____14532 = (FStar_Syntax_Syntax.as_arg res_t)
in (uu____14532)::[])
in ((null_wp), (uu____14523)))
in FStar_Syntax_Syntax.Tm_app (uu____14508))
in (FStar_Syntax_Syntax.mk uu____14507))
in (uu____14500 FStar_Pervasives_Native.None uu____14499)))
in (

let uu____14564 = (

let uu____14565 = (

let uu____14574 = (FStar_Syntax_Syntax.as_arg null_wp_res)
in (uu____14574)::[])
in {FStar_Syntax_Syntax.comp_univs = (res_u)::[]; FStar_Syntax_Syntax.effect_name = eff_name1; FStar_Syntax_Syntax.result_typ = res_t; FStar_Syntax_Syntax.effect_args = uu____14565; FStar_Syntax_Syntax.flags = []})
in (FStar_Syntax_Syntax.mk_Comp uu____14564))))))
end))
end)))


let build_lattice : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_new_effect (ne) -> begin
(

let effects = (

let uu___98_14605 = env.effects
in {decls = (((ne), (se.FStar_Syntax_Syntax.sigquals)))::env.effects.decls; order = uu___98_14605.order; joins = uu___98_14605.joins})
in (

let uu___99_14614 = env
in {solver = uu___99_14614.solver; range = uu___99_14614.range; curmodule = uu___99_14614.curmodule; gamma = uu___99_14614.gamma; gamma_sig = uu___99_14614.gamma_sig; gamma_cache = uu___99_14614.gamma_cache; modules = uu___99_14614.modules; expected_typ = uu___99_14614.expected_typ; sigtab = uu___99_14614.sigtab; is_pattern = uu___99_14614.is_pattern; instantiate_imp = uu___99_14614.instantiate_imp; effects = effects; generalize = uu___99_14614.generalize; letrecs = uu___99_14614.letrecs; top_level = uu___99_14614.top_level; check_uvars = uu___99_14614.check_uvars; use_eq = uu___99_14614.use_eq; is_iface = uu___99_14614.is_iface; admit = uu___99_14614.admit; lax = uu___99_14614.lax; lax_universes = uu___99_14614.lax_universes; failhard = uu___99_14614.failhard; nosynth = uu___99_14614.nosynth; tc_term = uu___99_14614.tc_term; type_of = uu___99_14614.type_of; universe_of = uu___99_14614.universe_of; check_type_of = uu___99_14614.check_type_of; use_bv_sorts = uu___99_14614.use_bv_sorts; qtbl_name_and_index = uu___99_14614.qtbl_name_and_index; normalized_eff_names = uu___99_14614.normalized_eff_names; proof_ns = uu___99_14614.proof_ns; synth_hook = uu___99_14614.synth_hook; splice = uu___99_14614.splice; is_native_tactic = uu___99_14614.is_native_tactic; identifier_info = uu___99_14614.identifier_info; tc_hooks = uu___99_14614.tc_hooks; dsenv = uu___99_14614.dsenv; dep_graph = uu___99_14614.dep_graph}))
end
| FStar_Syntax_Syntax.Sig_sub_effect (sub1) -> begin
(

let compose_edges = (fun e1 e2 -> (

let composed_lift = (

let mlift_wp = (fun u r wp1 -> (

let uu____14644 = (e1.mlift.mlift_wp u r wp1)
in (e2.mlift.mlift_wp u r uu____14644)))
in (

let mlift_term = (match (((e1.mlift.mlift_term), (e2.mlift.mlift_term))) with
| (FStar_Pervasives_Native.Some (l1), FStar_Pervasives_Native.Some (l2)) -> begin
FStar_Pervasives_Native.Some ((fun u t wp e -> (

let uu____14802 = (e1.mlift.mlift_wp u t wp)
in (

let uu____14803 = (l1 u t wp e)
in (l2 u t uu____14802 uu____14803)))))
end
| uu____14804 -> begin
FStar_Pervasives_Native.None
end)
in {mlift_wp = mlift_wp; mlift_term = mlift_term}))
in {msource = e1.msource; mtarget = e2.mtarget; mlift = composed_lift}))
in (

let mk_mlift_wp = (fun lift_t u r wp1 -> (

let uu____14876 = (inst_tscheme_with lift_t ((u)::[]))
in (match (uu____14876) with
| (uu____14883, lift_t1) -> begin
(

let uu____14885 = (

let uu____14892 = (

let uu____14893 = (

let uu____14908 = (

let uu____14917 = (FStar_Syntax_Syntax.as_arg r)
in (

let uu____14924 = (

let uu____14933 = (FStar_Syntax_Syntax.as_arg wp1)
in (uu____14933)::[])
in (uu____14917)::uu____14924))
in ((lift_t1), (uu____14908)))
in FStar_Syntax_Syntax.Tm_app (uu____14893))
in (FStar_Syntax_Syntax.mk uu____14892))
in (uu____14885 FStar_Pervasives_Native.None wp1.FStar_Syntax_Syntax.pos))
end)))
in (

let sub_mlift_wp = (match (sub1.FStar_Syntax_Syntax.lift_wp) with
| FStar_Pervasives_Native.Some (sub_lift_wp) -> begin
(mk_mlift_wp sub_lift_wp)
end
| FStar_Pervasives_Native.None -> begin
(failwith "sub effect should\'ve been elaborated at this stage")
end)
in (

let mk_mlift_term = (fun lift_t u r wp1 e -> (

let uu____15035 = (inst_tscheme_with lift_t ((u)::[]))
in (match (uu____15035) with
| (uu____15042, lift_t1) -> begin
(

let uu____15044 = (

let uu____15051 = (

let uu____15052 = (

let uu____15067 = (

let uu____15076 = (FStar_Syntax_Syntax.as_arg r)
in (

let uu____15083 = (

let uu____15092 = (FStar_Syntax_Syntax.as_arg wp1)
in (

let uu____15099 = (

let uu____15108 = (FStar_Syntax_Syntax.as_arg e)
in (uu____15108)::[])
in (uu____15092)::uu____15099))
in (uu____15076)::uu____15083))
in ((lift_t1), (uu____15067)))
in FStar_Syntax_Syntax.Tm_app (uu____15052))
in (FStar_Syntax_Syntax.mk uu____15051))
in (uu____15044 FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos))
end)))
in (

let sub_mlift_term = (FStar_Util.map_opt sub1.FStar_Syntax_Syntax.lift mk_mlift_term)
in (

let edge = {msource = sub1.FStar_Syntax_Syntax.source; mtarget = sub1.FStar_Syntax_Syntax.target; mlift = {mlift_wp = sub_mlift_wp; mlift_term = sub_mlift_term}}
in (

let id_edge = (fun l -> {msource = sub1.FStar_Syntax_Syntax.source; mtarget = sub1.FStar_Syntax_Syntax.target; mlift = identity_mlift})
in (

let print_mlift = (fun l -> (

let bogus_term = (fun s -> (

let uu____15198 = (

let uu____15199 = (FStar_Ident.lid_of_path ((s)::[]) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.lid_as_fv uu____15199 FStar_Syntax_Syntax.Delta_constant FStar_Pervasives_Native.None))
in (FStar_Syntax_Syntax.fv_to_tm uu____15198)))
in (

let arg = (bogus_term "ARG")
in (

let wp = (bogus_term "WP")
in (

let e = (bogus_term "COMP")
in (

let uu____15203 = (

let uu____15204 = (l.mlift_wp FStar_Syntax_Syntax.U_zero arg wp)
in (FStar_Syntax_Print.term_to_string uu____15204))
in (

let uu____15205 = (

let uu____15206 = (FStar_Util.map_opt l.mlift_term (fun l1 -> (

let uu____15232 = (l1 FStar_Syntax_Syntax.U_zero arg wp e)
in (FStar_Syntax_Print.term_to_string uu____15232))))
in (FStar_Util.dflt "none" uu____15206))
in (FStar_Util.format2 "{ wp : %s ; term : %s }" uu____15203 uu____15205))))))))
in (

let order = (edge)::env.effects.order
in (

let ms = (FStar_All.pipe_right env.effects.decls (FStar_List.map (fun uu____15258 -> (match (uu____15258) with
| (e, uu____15266) -> begin
e.FStar_Syntax_Syntax.mname
end))))
in (

let find_edge = (fun order1 uu____15289 -> (match (uu____15289) with
| (i, j) -> begin
(

let uu____15300 = (FStar_Ident.lid_equals i j)
in (match (uu____15300) with
| true -> begin
(FStar_All.pipe_right (id_edge i) (fun _0_17 -> FStar_Pervasives_Native.Some (_0_17)))
end
| uu____15305 -> begin
(FStar_All.pipe_right order1 (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals e.msource i) && (FStar_Ident.lid_equals e.mtarget j)))))
end))
end))
in (

let order1 = (

let fold_fun = (fun order1 k -> (

let uu____15332 = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> (

let uu____15342 = (FStar_Ident.lid_equals i k)
in (match (uu____15342) with
| true -> begin
[]
end
| uu____15345 -> begin
(FStar_All.pipe_right ms (FStar_List.collect (fun j -> (

let uu____15353 = (FStar_Ident.lid_equals j k)
in (match (uu____15353) with
| true -> begin
[]
end
| uu____15356 -> begin
(

let uu____15357 = (

let uu____15366 = (find_edge order1 ((i), (k)))
in (

let uu____15369 = (find_edge order1 ((k), (j)))
in ((uu____15366), (uu____15369))))
in (match (uu____15357) with
| (FStar_Pervasives_Native.Some (e1), FStar_Pervasives_Native.Some (e2)) -> begin
(

let uu____15384 = (compose_edges e1 e2)
in (uu____15384)::[])
end
| uu____15385 -> begin
[]
end))
end)))))
end)))))
in (FStar_List.append order1 uu____15332)))
in (FStar_All.pipe_right ms (FStar_List.fold_left fold_fun order)))
in (

let order2 = (FStar_Util.remove_dups (fun e1 e2 -> ((FStar_Ident.lid_equals e1.msource e2.msource) && (FStar_Ident.lid_equals e1.mtarget e2.mtarget))) order1)
in ((FStar_All.pipe_right order2 (FStar_List.iter (fun edge1 -> (

let uu____15415 = ((FStar_Ident.lid_equals edge1.msource FStar_Parser_Const.effect_DIV_lid) && (

let uu____15417 = (lookup_effect_quals env edge1.mtarget)
in (FStar_All.pipe_right uu____15417 (FStar_List.contains FStar_Syntax_Syntax.TotalEffect))))
in (match (uu____15415) with
| true -> begin
(

let uu____15422 = (

let uu____15427 = (FStar_Util.format1 "Divergent computations cannot be included in an effect %s marked \'total\'" edge1.mtarget.FStar_Ident.str)
in ((FStar_Errors.Fatal_DivergentComputationCannotBeIncludedInTotal), (uu____15427)))
in (

let uu____15428 = (get_range env)
in (FStar_Errors.raise_error uu____15422 uu____15428)))
end
| uu____15429 -> begin
()
end)))));
(

let joins = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> (FStar_All.pipe_right ms (FStar_List.collect (fun j -> (

let join_opt = (

let uu____15505 = (FStar_Ident.lid_equals i j)
in (match (uu____15505) with
| true -> begin
FStar_Pervasives_Native.Some (((i), ((id_edge i)), ((id_edge i))))
end
| uu____15520 -> begin
(FStar_All.pipe_right ms (FStar_List.fold_left (fun bopt k -> (

let uu____15554 = (

let uu____15563 = (find_edge order2 ((i), (k)))
in (

let uu____15566 = (find_edge order2 ((j), (k)))
in ((uu____15563), (uu____15566))))
in (match (uu____15554) with
| (FStar_Pervasives_Native.Some (ik), FStar_Pervasives_Native.Some (jk)) -> begin
(match (bopt) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.Some (((k), (ik), (jk)))
end
| FStar_Pervasives_Native.Some (ub, uu____15608, uu____15609) -> begin
(

let uu____15616 = (

let uu____15621 = (

let uu____15622 = (find_edge order2 ((k), (ub)))
in (FStar_Util.is_some uu____15622))
in (

let uu____15625 = (

let uu____15626 = (find_edge order2 ((ub), (k)))
in (FStar_Util.is_some uu____15626))
in ((uu____15621), (uu____15625))))
in (match (uu____15616) with
| (true, true) -> begin
(

let uu____15637 = (FStar_Ident.lid_equals k ub)
in (match (uu____15637) with
| true -> begin
((FStar_Errors.log_issue FStar_Range.dummyRange ((FStar_Errors.Warning_UpperBoundCandidateAlreadyVisited), ("Looking multiple times at the same upper bound candidate")));
bopt;
)
end
| uu____15647 -> begin
(failwith "Found a cycle in the lattice")
end))
end
| (false, false) -> begin
bopt
end
| (true, false) -> begin
FStar_Pervasives_Native.Some (((k), (ik), (jk)))
end
| (false, true) -> begin
bopt
end))
end)
end
| uu____15662 -> begin
bopt
end))) FStar_Pervasives_Native.None))
end))
in (match (join_opt) with
| FStar_Pervasives_Native.None -> begin
[]
end
| FStar_Pervasives_Native.Some (k, e1, e2) -> begin
(((i), (j), (k), (e1.mlift), (e2.mlift)))::[]
end))))))))
in (

let effects = (

let uu___100_15735 = env.effects
in {decls = uu___100_15735.decls; order = order2; joins = joins})
in (

let uu___101_15736 = env
in {solver = uu___101_15736.solver; range = uu___101_15736.range; curmodule = uu___101_15736.curmodule; gamma = uu___101_15736.gamma; gamma_sig = uu___101_15736.gamma_sig; gamma_cache = uu___101_15736.gamma_cache; modules = uu___101_15736.modules; expected_typ = uu___101_15736.expected_typ; sigtab = uu___101_15736.sigtab; is_pattern = uu___101_15736.is_pattern; instantiate_imp = uu___101_15736.instantiate_imp; effects = effects; generalize = uu___101_15736.generalize; letrecs = uu___101_15736.letrecs; top_level = uu___101_15736.top_level; check_uvars = uu___101_15736.check_uvars; use_eq = uu___101_15736.use_eq; is_iface = uu___101_15736.is_iface; admit = uu___101_15736.admit; lax = uu___101_15736.lax; lax_universes = uu___101_15736.lax_universes; failhard = uu___101_15736.failhard; nosynth = uu___101_15736.nosynth; tc_term = uu___101_15736.tc_term; type_of = uu___101_15736.type_of; universe_of = uu___101_15736.universe_of; check_type_of = uu___101_15736.check_type_of; use_bv_sorts = uu___101_15736.use_bv_sorts; qtbl_name_and_index = uu___101_15736.qtbl_name_and_index; normalized_eff_names = uu___101_15736.normalized_eff_names; proof_ns = uu___101_15736.proof_ns; synth_hook = uu___101_15736.synth_hook; splice = uu___101_15736.splice; is_native_tactic = uu___101_15736.is_native_tactic; identifier_info = uu___101_15736.identifier_info; tc_hooks = uu___101_15736.tc_hooks; dsenv = uu___101_15736.dsenv; dep_graph = uu___101_15736.dep_graph})));
))))))))))))))
end
| uu____15737 -> begin
env
end))


let comp_to_comp_typ : env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp_typ = (fun env c -> (

let c1 = (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t, FStar_Pervasives_Native.None) -> begin
(

let u = (env.universe_of env t)
in (FStar_Syntax_Syntax.mk_Total' t (FStar_Pervasives_Native.Some (u))))
end
| FStar_Syntax_Syntax.GTotal (t, FStar_Pervasives_Native.None) -> begin
(

let u = (env.universe_of env t)
in (FStar_Syntax_Syntax.mk_GTotal' t (FStar_Pervasives_Native.Some (u))))
end
| uu____15765 -> begin
c
end)
in (FStar_Syntax_Util.comp_to_comp_typ c1)))


let rec unfold_effect_abbrev : env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp_typ = (fun env comp -> (

let c = (comp_to_comp_typ env comp)
in (

let uu____15777 = (lookup_effect_abbrev env c.FStar_Syntax_Syntax.comp_univs c.FStar_Syntax_Syntax.effect_name)
in (match (uu____15777) with
| FStar_Pervasives_Native.None -> begin
c
end
| FStar_Pervasives_Native.Some (binders, cdef) -> begin
(

let uu____15794 = (FStar_Syntax_Subst.open_comp binders cdef)
in (match (uu____15794) with
| (binders1, cdef1) -> begin
((match ((Prims.op_disEquality (FStar_List.length binders1) ((FStar_List.length c.FStar_Syntax_Syntax.effect_args) + (Prims.parse_int "1")))) with
| true -> begin
(

let uu____15813 = (

let uu____15818 = (

let uu____15819 = (FStar_Util.string_of_int (FStar_List.length binders1))
in (

let uu____15824 = (FStar_Util.string_of_int ((FStar_List.length c.FStar_Syntax_Syntax.effect_args) + (Prims.parse_int "1")))
in (

let uu____15831 = (

let uu____15832 = (FStar_Syntax_Syntax.mk_Comp c)
in (FStar_Syntax_Print.comp_to_string uu____15832))
in (FStar_Util.format3 "Effect constructor is not fully applied; expected %s args, got %s args, i.e., %s" uu____15819 uu____15824 uu____15831))))
in ((FStar_Errors.Fatal_ConstructorArgLengthMismatch), (uu____15818)))
in (FStar_Errors.raise_error uu____15813 comp.FStar_Syntax_Syntax.pos))
end
| uu____15833 -> begin
()
end);
(

let inst1 = (

let uu____15837 = (

let uu____15846 = (FStar_Syntax_Syntax.as_arg c.FStar_Syntax_Syntax.result_typ)
in (uu____15846)::c.FStar_Syntax_Syntax.effect_args)
in (FStar_List.map2 (fun uu____15875 uu____15876 -> (match (((uu____15875), (uu____15876))) with
| ((x, uu____15898), (t, uu____15900)) -> begin
FStar_Syntax_Syntax.NT (((x), (t)))
end)) binders1 uu____15837))
in (

let c1 = (FStar_Syntax_Subst.subst_comp inst1 cdef1)
in (

let c2 = (

let uu____15919 = (

let uu___102_15920 = (comp_to_comp_typ env c1)
in {FStar_Syntax_Syntax.comp_univs = uu___102_15920.FStar_Syntax_Syntax.comp_univs; FStar_Syntax_Syntax.effect_name = uu___102_15920.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = uu___102_15920.FStar_Syntax_Syntax.result_typ; FStar_Syntax_Syntax.effect_args = uu___102_15920.FStar_Syntax_Syntax.effect_args; FStar_Syntax_Syntax.flags = c.FStar_Syntax_Syntax.flags})
in (FStar_All.pipe_right uu____15919 FStar_Syntax_Syntax.mk_Comp))
in (unfold_effect_abbrev env c2))));
)
end))
end))))


let effect_repr_aux : Prims.bool  ->  env  ->  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax FStar_Pervasives_Native.option = (fun only_reifiable env c u_c -> (

let effect_name = (norm_eff_name env (FStar_Syntax_Util.comp_effect_name c))
in (

let uu____15950 = (effect_decl_opt env effect_name)
in (match (uu____15950) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some (ed, qualifiers) -> begin
(

let uu____15983 = (only_reifiable && (

let uu____15985 = (FStar_All.pipe_right qualifiers (FStar_List.contains FStar_Syntax_Syntax.Reifiable))
in (not (uu____15985))))
in (match (uu____15983) with
| true -> begin
FStar_Pervasives_Native.None
end
| uu____15994 -> begin
(match (ed.FStar_Syntax_Syntax.repr.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
FStar_Pervasives_Native.None
end
| uu____16001 -> begin
(

let c1 = (unfold_effect_abbrev env c)
in (

let res_typ = c1.FStar_Syntax_Syntax.result_typ
in (

let wp = (match (c1.FStar_Syntax_Syntax.effect_args) with
| (hd1)::uu____16020 -> begin
hd1
end
| [] -> begin
(

let name = (FStar_Ident.string_of_lid effect_name)
in (

let message = (

let uu____16049 = (FStar_Util.format1 "Not enough arguments for effect %s. " name)
in (Prims.strcat uu____16049 (Prims.strcat "This usually happens when you use a partially applied DM4F effect, " "like [TAC int] instead of [Tac int].")))
in (

let uu____16050 = (get_range env)
in (FStar_Errors.raise_error ((FStar_Errors.Fatal_NotEnoughArgumentsForEffect), (message)) uu____16050))))
end)
in (

let repr = (inst_effect_fun_with ((u_c)::[]) env ed (([]), (ed.FStar_Syntax_Syntax.repr)))
in (

let uu____16062 = (

let uu____16065 = (get_range env)
in (

let uu____16066 = (

let uu____16073 = (

let uu____16074 = (

let uu____16089 = (

let uu____16098 = (FStar_Syntax_Syntax.as_arg res_typ)
in (uu____16098)::(wp)::[])
in ((repr), (uu____16089)))
in FStar_Syntax_Syntax.Tm_app (uu____16074))
in (FStar_Syntax_Syntax.mk uu____16073))
in (uu____16066 FStar_Pervasives_Native.None uu____16065)))
in FStar_Pervasives_Native.Some (uu____16062))))))
end)
end))
end))))


let effect_repr : env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.term FStar_Pervasives_Native.option = (fun env c u_c -> (effect_repr_aux false env c u_c))


let reify_comp : env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.term = (fun env c u_c -> (

let no_reify = (fun l -> (

let uu____16178 = (

let uu____16183 = (

let uu____16184 = (FStar_Ident.string_of_lid l)
in (FStar_Util.format1 "Effect %s cannot be reified" uu____16184))
in ((FStar_Errors.Fatal_EffectCannotBeReified), (uu____16183)))
in (

let uu____16185 = (get_range env)
in (FStar_Errors.raise_error uu____16178 uu____16185))))
in (

let uu____16186 = (effect_repr_aux true env c u_c)
in (match (uu____16186) with
| FStar_Pervasives_Native.None -> begin
(no_reify (FStar_Syntax_Util.comp_effect_name c))
end
| FStar_Pervasives_Native.Some (tm) -> begin
tm
end))))


let is_reifiable_effect : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env effect_lid -> (

let quals = (lookup_effect_quals env effect_lid)
in (FStar_List.contains FStar_Syntax_Syntax.Reifiable quals)))


let is_reifiable : env  ->  FStar_Syntax_Syntax.residual_comp  ->  Prims.bool = (fun env c -> (is_reifiable_effect env c.FStar_Syntax_Syntax.residual_effect))


let is_reifiable_comp : env  ->  FStar_Syntax_Syntax.comp  ->  Prims.bool = (fun env c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (ct) -> begin
(is_reifiable_effect env ct.FStar_Syntax_Syntax.effect_name)
end
| uu____16232 -> begin
false
end))


let is_reifiable_function : env  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (fun env t -> (

let uu____16243 = (

let uu____16244 = (FStar_Syntax_Subst.compress t)
in uu____16244.FStar_Syntax_Syntax.n)
in (match (uu____16243) with
| FStar_Syntax_Syntax.Tm_arrow (uu____16247, c) -> begin
(is_reifiable_comp env c)
end
| uu____16265 -> begin
false
end)))


let push_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env s -> (

let sb = (((FStar_Syntax_Util.lids_of_sigelt s)), (s))
in (

let env1 = (

let uu___103_16286 = env
in {solver = uu___103_16286.solver; range = uu___103_16286.range; curmodule = uu___103_16286.curmodule; gamma = uu___103_16286.gamma; gamma_sig = (sb)::env.gamma_sig; gamma_cache = uu___103_16286.gamma_cache; modules = uu___103_16286.modules; expected_typ = uu___103_16286.expected_typ; sigtab = uu___103_16286.sigtab; is_pattern = uu___103_16286.is_pattern; instantiate_imp = uu___103_16286.instantiate_imp; effects = uu___103_16286.effects; generalize = uu___103_16286.generalize; letrecs = uu___103_16286.letrecs; top_level = uu___103_16286.top_level; check_uvars = uu___103_16286.check_uvars; use_eq = uu___103_16286.use_eq; is_iface = uu___103_16286.is_iface; admit = uu___103_16286.admit; lax = uu___103_16286.lax; lax_universes = uu___103_16286.lax_universes; failhard = uu___103_16286.failhard; nosynth = uu___103_16286.nosynth; tc_term = uu___103_16286.tc_term; type_of = uu___103_16286.type_of; universe_of = uu___103_16286.universe_of; check_type_of = uu___103_16286.check_type_of; use_bv_sorts = uu___103_16286.use_bv_sorts; qtbl_name_and_index = uu___103_16286.qtbl_name_and_index; normalized_eff_names = uu___103_16286.normalized_eff_names; proof_ns = uu___103_16286.proof_ns; synth_hook = uu___103_16286.synth_hook; splice = uu___103_16286.splice; is_native_tactic = uu___103_16286.is_native_tactic; identifier_info = uu___103_16286.identifier_info; tc_hooks = uu___103_16286.tc_hooks; dsenv = uu___103_16286.dsenv; dep_graph = uu___103_16286.dep_graph})
in ((env1.tc_hooks.tc_push_in_gamma_hook env1 (FStar_Util.Inr (sb)));
(build_lattice env1 s);
))))


let push_local_binding : env  ->  FStar_Syntax_Syntax.binding  ->  env = (fun env b -> (

let uu___104_16298 = env
in {solver = uu___104_16298.solver; range = uu___104_16298.range; curmodule = uu___104_16298.curmodule; gamma = (b)::env.gamma; gamma_sig = uu___104_16298.gamma_sig; gamma_cache = uu___104_16298.gamma_cache; modules = uu___104_16298.modules; expected_typ = uu___104_16298.expected_typ; sigtab = uu___104_16298.sigtab; is_pattern = uu___104_16298.is_pattern; instantiate_imp = uu___104_16298.instantiate_imp; effects = uu___104_16298.effects; generalize = uu___104_16298.generalize; letrecs = uu___104_16298.letrecs; top_level = uu___104_16298.top_level; check_uvars = uu___104_16298.check_uvars; use_eq = uu___104_16298.use_eq; is_iface = uu___104_16298.is_iface; admit = uu___104_16298.admit; lax = uu___104_16298.lax; lax_universes = uu___104_16298.lax_universes; failhard = uu___104_16298.failhard; nosynth = uu___104_16298.nosynth; tc_term = uu___104_16298.tc_term; type_of = uu___104_16298.type_of; universe_of = uu___104_16298.universe_of; check_type_of = uu___104_16298.check_type_of; use_bv_sorts = uu___104_16298.use_bv_sorts; qtbl_name_and_index = uu___104_16298.qtbl_name_and_index; normalized_eff_names = uu___104_16298.normalized_eff_names; proof_ns = uu___104_16298.proof_ns; synth_hook = uu___104_16298.synth_hook; splice = uu___104_16298.splice; is_native_tactic = uu___104_16298.is_native_tactic; identifier_info = uu___104_16298.identifier_info; tc_hooks = uu___104_16298.tc_hooks; dsenv = uu___104_16298.dsenv; dep_graph = uu___104_16298.dep_graph}))


let push_bv : env  ->  FStar_Syntax_Syntax.bv  ->  env = (fun env x -> (push_local_binding env (FStar_Syntax_Syntax.Binding_var (x))))


let push_bvs : env  ->  FStar_Syntax_Syntax.bv Prims.list  ->  env = (fun env bvs -> (FStar_List.fold_left (fun env1 bv -> (push_bv env1 bv)) env bvs))


let pop_bv : env  ->  (FStar_Syntax_Syntax.bv * env) FStar_Pervasives_Native.option = (fun env -> (match (env.gamma) with
| (FStar_Syntax_Syntax.Binding_var (x))::rest -> begin
FStar_Pervasives_Native.Some (((x), ((

let uu___105_16353 = env
in {solver = uu___105_16353.solver; range = uu___105_16353.range; curmodule = uu___105_16353.curmodule; gamma = rest; gamma_sig = uu___105_16353.gamma_sig; gamma_cache = uu___105_16353.gamma_cache; modules = uu___105_16353.modules; expected_typ = uu___105_16353.expected_typ; sigtab = uu___105_16353.sigtab; is_pattern = uu___105_16353.is_pattern; instantiate_imp = uu___105_16353.instantiate_imp; effects = uu___105_16353.effects; generalize = uu___105_16353.generalize; letrecs = uu___105_16353.letrecs; top_level = uu___105_16353.top_level; check_uvars = uu___105_16353.check_uvars; use_eq = uu___105_16353.use_eq; is_iface = uu___105_16353.is_iface; admit = uu___105_16353.admit; lax = uu___105_16353.lax; lax_universes = uu___105_16353.lax_universes; failhard = uu___105_16353.failhard; nosynth = uu___105_16353.nosynth; tc_term = uu___105_16353.tc_term; type_of = uu___105_16353.type_of; universe_of = uu___105_16353.universe_of; check_type_of = uu___105_16353.check_type_of; use_bv_sorts = uu___105_16353.use_bv_sorts; qtbl_name_and_index = uu___105_16353.qtbl_name_and_index; normalized_eff_names = uu___105_16353.normalized_eff_names; proof_ns = uu___105_16353.proof_ns; synth_hook = uu___105_16353.synth_hook; splice = uu___105_16353.splice; is_native_tactic = uu___105_16353.is_native_tactic; identifier_info = uu___105_16353.identifier_info; tc_hooks = uu___105_16353.tc_hooks; dsenv = uu___105_16353.dsenv; dep_graph = uu___105_16353.dep_graph}))))
end
| uu____16354 -> begin
FStar_Pervasives_Native.None
end))


let push_binders : env  ->  FStar_Syntax_Syntax.binders  ->  env = (fun env bs -> (FStar_List.fold_left (fun env1 uu____16380 -> (match (uu____16380) with
| (x, uu____16386) -> begin
(push_bv env1 x)
end)) env bs))


let binding_of_lb : FStar_Syntax_Syntax.lbname  ->  (FStar_Syntax_Syntax.univ_name Prims.list * FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)  ->  FStar_Syntax_Syntax.binding = (fun x t -> (match (x) with
| FStar_Util.Inl (x1) -> begin
(

let x2 = (

let uu___106_16416 = x1
in {FStar_Syntax_Syntax.ppname = uu___106_16416.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___106_16416.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = (FStar_Pervasives_Native.snd t)})
in FStar_Syntax_Syntax.Binding_var (x2))
end
| FStar_Util.Inr (fv) -> begin
FStar_Syntax_Syntax.Binding_lid (((fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v), (t)))
end))


let push_let_binding : env  ->  FStar_Syntax_Syntax.lbname  ->  FStar_Syntax_Syntax.tscheme  ->  env = (fun env lb ts -> (push_local_binding env (binding_of_lb lb ts)))


let push_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env m -> ((add_sigelts env m.FStar_Syntax_Syntax.exports);
(

let uu___107_16456 = env
in {solver = uu___107_16456.solver; range = uu___107_16456.range; curmodule = uu___107_16456.curmodule; gamma = []; gamma_sig = []; gamma_cache = uu___107_16456.gamma_cache; modules = (m)::env.modules; expected_typ = FStar_Pervasives_Native.None; sigtab = uu___107_16456.sigtab; is_pattern = uu___107_16456.is_pattern; instantiate_imp = uu___107_16456.instantiate_imp; effects = uu___107_16456.effects; generalize = uu___107_16456.generalize; letrecs = uu___107_16456.letrecs; top_level = uu___107_16456.top_level; check_uvars = uu___107_16456.check_uvars; use_eq = uu___107_16456.use_eq; is_iface = uu___107_16456.is_iface; admit = uu___107_16456.admit; lax = uu___107_16456.lax; lax_universes = uu___107_16456.lax_universes; failhard = uu___107_16456.failhard; nosynth = uu___107_16456.nosynth; tc_term = uu___107_16456.tc_term; type_of = uu___107_16456.type_of; universe_of = uu___107_16456.universe_of; check_type_of = uu___107_16456.check_type_of; use_bv_sorts = uu___107_16456.use_bv_sorts; qtbl_name_and_index = uu___107_16456.qtbl_name_and_index; normalized_eff_names = uu___107_16456.normalized_eff_names; proof_ns = uu___107_16456.proof_ns; synth_hook = uu___107_16456.synth_hook; splice = uu___107_16456.splice; is_native_tactic = uu___107_16456.is_native_tactic; identifier_info = uu___107_16456.identifier_info; tc_hooks = uu___107_16456.tc_hooks; dsenv = uu___107_16456.dsenv; dep_graph = uu___107_16456.dep_graph});
))


let push_univ_vars : env  ->  FStar_Syntax_Syntax.univ_names  ->  env = (fun env xs -> (FStar_List.fold_left (fun env1 x -> (push_local_binding env1 (FStar_Syntax_Syntax.Binding_univ (x)))) env xs))


let open_universes_in : env  ->  FStar_Syntax_Syntax.univ_names  ->  FStar_Syntax_Syntax.term Prims.list  ->  (env * FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term Prims.list) = (fun env uvs terms -> (

let uu____16498 = (FStar_Syntax_Subst.univ_var_opening uvs)
in (match (uu____16498) with
| (univ_subst, univ_vars) -> begin
(

let env' = (push_univ_vars env univ_vars)
in (

let uu____16526 = (FStar_List.map (FStar_Syntax_Subst.subst univ_subst) terms)
in ((env'), (univ_vars), (uu____16526))))
end)))


let set_expected_typ : env  ->  FStar_Syntax_Syntax.typ  ->  env = (fun env t -> (

let uu___108_16541 = env
in {solver = uu___108_16541.solver; range = uu___108_16541.range; curmodule = uu___108_16541.curmodule; gamma = uu___108_16541.gamma; gamma_sig = uu___108_16541.gamma_sig; gamma_cache = uu___108_16541.gamma_cache; modules = uu___108_16541.modules; expected_typ = FStar_Pervasives_Native.Some (t); sigtab = uu___108_16541.sigtab; is_pattern = uu___108_16541.is_pattern; instantiate_imp = uu___108_16541.instantiate_imp; effects = uu___108_16541.effects; generalize = uu___108_16541.generalize; letrecs = uu___108_16541.letrecs; top_level = uu___108_16541.top_level; check_uvars = uu___108_16541.check_uvars; use_eq = false; is_iface = uu___108_16541.is_iface; admit = uu___108_16541.admit; lax = uu___108_16541.lax; lax_universes = uu___108_16541.lax_universes; failhard = uu___108_16541.failhard; nosynth = uu___108_16541.nosynth; tc_term = uu___108_16541.tc_term; type_of = uu___108_16541.type_of; universe_of = uu___108_16541.universe_of; check_type_of = uu___108_16541.check_type_of; use_bv_sorts = uu___108_16541.use_bv_sorts; qtbl_name_and_index = uu___108_16541.qtbl_name_and_index; normalized_eff_names = uu___108_16541.normalized_eff_names; proof_ns = uu___108_16541.proof_ns; synth_hook = uu___108_16541.synth_hook; splice = uu___108_16541.splice; is_native_tactic = uu___108_16541.is_native_tactic; identifier_info = uu___108_16541.identifier_info; tc_hooks = uu___108_16541.tc_hooks; dsenv = uu___108_16541.dsenv; dep_graph = uu___108_16541.dep_graph}))


let expected_typ : env  ->  FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option = (fun env -> (match (env.expected_typ) with
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end
| FStar_Pervasives_Native.Some (t) -> begin
FStar_Pervasives_Native.Some (t)
end))


let clear_expected_typ : env  ->  (env * FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option) = (fun env_ -> (

let uu____16569 = (expected_typ env_)
in (((

let uu___109_16575 = env_
in {solver = uu___109_16575.solver; range = uu___109_16575.range; curmodule = uu___109_16575.curmodule; gamma = uu___109_16575.gamma; gamma_sig = uu___109_16575.gamma_sig; gamma_cache = uu___109_16575.gamma_cache; modules = uu___109_16575.modules; expected_typ = FStar_Pervasives_Native.None; sigtab = uu___109_16575.sigtab; is_pattern = uu___109_16575.is_pattern; instantiate_imp = uu___109_16575.instantiate_imp; effects = uu___109_16575.effects; generalize = uu___109_16575.generalize; letrecs = uu___109_16575.letrecs; top_level = uu___109_16575.top_level; check_uvars = uu___109_16575.check_uvars; use_eq = false; is_iface = uu___109_16575.is_iface; admit = uu___109_16575.admit; lax = uu___109_16575.lax; lax_universes = uu___109_16575.lax_universes; failhard = uu___109_16575.failhard; nosynth = uu___109_16575.nosynth; tc_term = uu___109_16575.tc_term; type_of = uu___109_16575.type_of; universe_of = uu___109_16575.universe_of; check_type_of = uu___109_16575.check_type_of; use_bv_sorts = uu___109_16575.use_bv_sorts; qtbl_name_and_index = uu___109_16575.qtbl_name_and_index; normalized_eff_names = uu___109_16575.normalized_eff_names; proof_ns = uu___109_16575.proof_ns; synth_hook = uu___109_16575.synth_hook; splice = uu___109_16575.splice; is_native_tactic = uu___109_16575.is_native_tactic; identifier_info = uu___109_16575.identifier_info; tc_hooks = uu___109_16575.tc_hooks; dsenv = uu___109_16575.dsenv; dep_graph = uu___109_16575.dep_graph})), (uu____16569))))


let finish_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (

let empty_lid = (

let uu____16585 = (

let uu____16588 = (FStar_Ident.id_of_text "")
in (uu____16588)::[])
in (FStar_Ident.lid_of_ids uu____16585))
in (fun env m -> (

let sigs = (

let uu____16594 = (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name FStar_Parser_Const.prims_lid)
in (match (uu____16594) with
| true -> begin
(

let uu____16597 = (FStar_All.pipe_right env.gamma_sig (FStar_List.map FStar_Pervasives_Native.snd))
in (FStar_All.pipe_right uu____16597 FStar_List.rev))
end
| uu____16622 -> begin
m.FStar_Syntax_Syntax.exports
end))
in ((add_sigelts env sigs);
(

let uu___110_16624 = env
in {solver = uu___110_16624.solver; range = uu___110_16624.range; curmodule = empty_lid; gamma = []; gamma_sig = []; gamma_cache = uu___110_16624.gamma_cache; modules = (m)::env.modules; expected_typ = uu___110_16624.expected_typ; sigtab = uu___110_16624.sigtab; is_pattern = uu___110_16624.is_pattern; instantiate_imp = uu___110_16624.instantiate_imp; effects = uu___110_16624.effects; generalize = uu___110_16624.generalize; letrecs = uu___110_16624.letrecs; top_level = uu___110_16624.top_level; check_uvars = uu___110_16624.check_uvars; use_eq = uu___110_16624.use_eq; is_iface = uu___110_16624.is_iface; admit = uu___110_16624.admit; lax = uu___110_16624.lax; lax_universes = uu___110_16624.lax_universes; failhard = uu___110_16624.failhard; nosynth = uu___110_16624.nosynth; tc_term = uu___110_16624.tc_term; type_of = uu___110_16624.type_of; universe_of = uu___110_16624.universe_of; check_type_of = uu___110_16624.check_type_of; use_bv_sorts = uu___110_16624.use_bv_sorts; qtbl_name_and_index = uu___110_16624.qtbl_name_and_index; normalized_eff_names = uu___110_16624.normalized_eff_names; proof_ns = uu___110_16624.proof_ns; synth_hook = uu___110_16624.synth_hook; splice = uu___110_16624.splice; is_native_tactic = uu___110_16624.is_native_tactic; identifier_info = uu___110_16624.identifier_info; tc_hooks = uu___110_16624.tc_hooks; dsenv = uu___110_16624.dsenv; dep_graph = uu___110_16624.dep_graph});
))))


let uvars_in_env : env  ->  FStar_Syntax_Syntax.uvars = (fun env -> (

let no_uvs = (FStar_Syntax_Free.new_uv_set ())
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (FStar_Syntax_Syntax.Binding_univ (uu____16675))::tl1 -> begin
(aux out tl1)
end
| (FStar_Syntax_Syntax.Binding_lid (uu____16679, (uu____16680, t)))::tl1 -> begin
(

let uu____16701 = (

let uu____16704 = (FStar_Syntax_Free.uvars t)
in (ext out uu____16704))
in (aux uu____16701 tl1))
end
| (FStar_Syntax_Syntax.Binding_var ({FStar_Syntax_Syntax.ppname = uu____16707; FStar_Syntax_Syntax.index = uu____16708; FStar_Syntax_Syntax.sort = t}))::tl1 -> begin
(

let uu____16715 = (

let uu____16718 = (FStar_Syntax_Free.uvars t)
in (ext out uu____16718))
in (aux uu____16715 tl1))
end))
in (aux no_uvs env.gamma)))))


let univ_vars : env  ->  FStar_Syntax_Syntax.universe_uvar FStar_Util.set = (fun env -> (

let no_univs = (FStar_Syntax_Free.new_universe_uvar_set ())
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (FStar_Syntax_Syntax.Binding_univ (uu____16775))::tl1 -> begin
(aux out tl1)
end
| (FStar_Syntax_Syntax.Binding_lid (uu____16779, (uu____16780, t)))::tl1 -> begin
(

let uu____16801 = (

let uu____16804 = (FStar_Syntax_Free.univs t)
in (ext out uu____16804))
in (aux uu____16801 tl1))
end
| (FStar_Syntax_Syntax.Binding_var ({FStar_Syntax_Syntax.ppname = uu____16807; FStar_Syntax_Syntax.index = uu____16808; FStar_Syntax_Syntax.sort = t}))::tl1 -> begin
(

let uu____16815 = (

let uu____16818 = (FStar_Syntax_Free.univs t)
in (ext out uu____16818))
in (aux uu____16815 tl1))
end))
in (aux no_univs env.gamma)))))


let univnames : env  ->  FStar_Syntax_Syntax.univ_name FStar_Util.set = (fun env -> (

let no_univ_names = FStar_Syntax_Syntax.no_universe_names
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (FStar_Syntax_Syntax.Binding_univ (uname))::tl1 -> begin
(

let uu____16879 = (FStar_Util.set_add uname out)
in (aux uu____16879 tl1))
end
| (FStar_Syntax_Syntax.Binding_lid (uu____16882, (uu____16883, t)))::tl1 -> begin
(

let uu____16904 = (

let uu____16907 = (FStar_Syntax_Free.univnames t)
in (ext out uu____16907))
in (aux uu____16904 tl1))
end
| (FStar_Syntax_Syntax.Binding_var ({FStar_Syntax_Syntax.ppname = uu____16910; FStar_Syntax_Syntax.index = uu____16911; FStar_Syntax_Syntax.sort = t}))::tl1 -> begin
(

let uu____16918 = (

let uu____16921 = (FStar_Syntax_Free.univnames t)
in (ext out uu____16921))
in (aux uu____16918 tl1))
end))
in (aux no_univ_names env.gamma)))))


let bound_vars_of_bindings : FStar_Syntax_Syntax.binding Prims.list  ->  FStar_Syntax_Syntax.bv Prims.list = (fun bs -> (FStar_All.pipe_right bs (FStar_List.collect (fun uu___85_16941 -> (match (uu___85_16941) with
| FStar_Syntax_Syntax.Binding_var (x) -> begin
(x)::[]
end
| FStar_Syntax_Syntax.Binding_lid (uu____16945) -> begin
[]
end
| FStar_Syntax_Syntax.Binding_univ (uu____16958) -> begin
[]
end)))))


let binders_of_bindings : FStar_Syntax_Syntax.binding Prims.list  ->  FStar_Syntax_Syntax.binders = (fun bs -> (

let uu____16968 = (

let uu____16975 = (bound_vars_of_bindings bs)
in (FStar_All.pipe_right uu____16975 (FStar_List.map FStar_Syntax_Syntax.mk_binder)))
in (FStar_All.pipe_right uu____16968 FStar_List.rev)))


let bound_vars : env  ->  FStar_Syntax_Syntax.bv Prims.list = (fun env -> (bound_vars_of_bindings env.gamma))


let all_binders : env  ->  FStar_Syntax_Syntax.binders = (fun env -> (binders_of_bindings env.gamma))


let print_gamma : FStar_Syntax_Syntax.gamma  ->  Prims.string = (fun gamma -> (

let uu____17013 = (FStar_All.pipe_right gamma (FStar_List.map (fun uu___86_17023 -> (match (uu___86_17023) with
| FStar_Syntax_Syntax.Binding_var (x) -> begin
(

let uu____17025 = (FStar_Syntax_Print.bv_to_string x)
in (Prims.strcat "Binding_var " uu____17025))
end
| FStar_Syntax_Syntax.Binding_univ (u) -> begin
(Prims.strcat "Binding_univ " u.FStar_Ident.idText)
end
| FStar_Syntax_Syntax.Binding_lid (l, uu____17028) -> begin
(

let uu____17045 = (FStar_Ident.string_of_lid l)
in (Prims.strcat "Binding_lid " uu____17045))
end))))
in (FStar_All.pipe_right uu____17013 (FStar_String.concat "::\n"))))


let string_of_delta_level : delta_level  ->  Prims.string = (fun uu___87_17052 -> (match (uu___87_17052) with
| NoDelta -> begin
"NoDelta"
end
| Inlining -> begin
"Inlining"
end
| Eager_unfolding_only -> begin
"Eager_unfolding_only"
end
| Unfold (uu____17053) -> begin
"Unfold _"
end
| UnfoldTac -> begin
"UnfoldTac"
end))


let lidents : env  ->  FStar_Ident.lident Prims.list = (fun env -> (

let keys = (FStar_List.collect FStar_Pervasives_Native.fst env.gamma_sig)
in (FStar_Util.smap_fold (sigtab env) (fun uu____17073 v1 keys1 -> (FStar_List.append (FStar_Syntax_Util.lids_of_sigelt v1) keys1)) keys)))


let should_enc_path : env  ->  Prims.string Prims.list  ->  Prims.bool = (fun env path -> (

let rec list_prefix = (fun xs ys -> (match (((xs), (ys))) with
| ([], uu____17115) -> begin
true
end
| ((x)::xs1, (y)::ys1) -> begin
((Prims.op_Equality x y) && (list_prefix xs1 ys1))
end
| (uu____17134, uu____17135) -> begin
false
end))
in (

let uu____17144 = (FStar_List.tryFind (fun uu____17162 -> (match (uu____17162) with
| (p, uu____17170) -> begin
(list_prefix p path)
end)) env.proof_ns)
in (match (uu____17144) with
| FStar_Pervasives_Native.None -> begin
false
end
| FStar_Pervasives_Native.Some (uu____17181, b) -> begin
b
end))))


let should_enc_lid : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____17203 = (FStar_Ident.path_of_lid lid)
in (should_enc_path env uu____17203)))


let cons_proof_ns : Prims.bool  ->  env  ->  name_prefix  ->  env = (fun b e path -> (

let uu___111_17221 = e
in {solver = uu___111_17221.solver; range = uu___111_17221.range; curmodule = uu___111_17221.curmodule; gamma = uu___111_17221.gamma; gamma_sig = uu___111_17221.gamma_sig; gamma_cache = uu___111_17221.gamma_cache; modules = uu___111_17221.modules; expected_typ = uu___111_17221.expected_typ; sigtab = uu___111_17221.sigtab; is_pattern = uu___111_17221.is_pattern; instantiate_imp = uu___111_17221.instantiate_imp; effects = uu___111_17221.effects; generalize = uu___111_17221.generalize; letrecs = uu___111_17221.letrecs; top_level = uu___111_17221.top_level; check_uvars = uu___111_17221.check_uvars; use_eq = uu___111_17221.use_eq; is_iface = uu___111_17221.is_iface; admit = uu___111_17221.admit; lax = uu___111_17221.lax; lax_universes = uu___111_17221.lax_universes; failhard = uu___111_17221.failhard; nosynth = uu___111_17221.nosynth; tc_term = uu___111_17221.tc_term; type_of = uu___111_17221.type_of; universe_of = uu___111_17221.universe_of; check_type_of = uu___111_17221.check_type_of; use_bv_sorts = uu___111_17221.use_bv_sorts; qtbl_name_and_index = uu___111_17221.qtbl_name_and_index; normalized_eff_names = uu___111_17221.normalized_eff_names; proof_ns = (((path), (b)))::e.proof_ns; synth_hook = uu___111_17221.synth_hook; splice = uu___111_17221.splice; is_native_tactic = uu___111_17221.is_native_tactic; identifier_info = uu___111_17221.identifier_info; tc_hooks = uu___111_17221.tc_hooks; dsenv = uu___111_17221.dsenv; dep_graph = uu___111_17221.dep_graph}))


let add_proof_ns : env  ->  name_prefix  ->  env = (fun e path -> (cons_proof_ns true e path))


let rem_proof_ns : env  ->  name_prefix  ->  env = (fun e path -> (cons_proof_ns false e path))


let get_proof_ns : env  ->  proof_namespace = (fun e -> e.proof_ns)


let set_proof_ns : proof_namespace  ->  env  ->  env = (fun ns e -> (

let uu___112_17261 = e
in {solver = uu___112_17261.solver; range = uu___112_17261.range; curmodule = uu___112_17261.curmodule; gamma = uu___112_17261.gamma; gamma_sig = uu___112_17261.gamma_sig; gamma_cache = uu___112_17261.gamma_cache; modules = uu___112_17261.modules; expected_typ = uu___112_17261.expected_typ; sigtab = uu___112_17261.sigtab; is_pattern = uu___112_17261.is_pattern; instantiate_imp = uu___112_17261.instantiate_imp; effects = uu___112_17261.effects; generalize = uu___112_17261.generalize; letrecs = uu___112_17261.letrecs; top_level = uu___112_17261.top_level; check_uvars = uu___112_17261.check_uvars; use_eq = uu___112_17261.use_eq; is_iface = uu___112_17261.is_iface; admit = uu___112_17261.admit; lax = uu___112_17261.lax; lax_universes = uu___112_17261.lax_universes; failhard = uu___112_17261.failhard; nosynth = uu___112_17261.nosynth; tc_term = uu___112_17261.tc_term; type_of = uu___112_17261.type_of; universe_of = uu___112_17261.universe_of; check_type_of = uu___112_17261.check_type_of; use_bv_sorts = uu___112_17261.use_bv_sorts; qtbl_name_and_index = uu___112_17261.qtbl_name_and_index; normalized_eff_names = uu___112_17261.normalized_eff_names; proof_ns = ns; synth_hook = uu___112_17261.synth_hook; splice = uu___112_17261.splice; is_native_tactic = uu___112_17261.is_native_tactic; identifier_info = uu___112_17261.identifier_info; tc_hooks = uu___112_17261.tc_hooks; dsenv = uu___112_17261.dsenv; dep_graph = uu___112_17261.dep_graph}))


let unbound_vars : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.bv FStar_Util.set = (fun e t -> (

let uu____17276 = (FStar_Syntax_Free.names t)
in (

let uu____17279 = (bound_vars e)
in (FStar_List.fold_left (fun s bv -> (FStar_Util.set_remove bv s)) uu____17276 uu____17279))))


let closed : env  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (fun e t -> (

let uu____17300 = (unbound_vars e t)
in (FStar_Util.set_is_empty uu____17300)))


let closed' : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____17308 = (FStar_Syntax_Free.names t)
in (FStar_Util.set_is_empty uu____17308)))


let string_of_proof_ns : env  ->  Prims.string = (fun env -> (

let aux = (fun uu____17327 -> (match (uu____17327) with
| (p, b) -> begin
(match (((Prims.op_Equality p []) && b)) with
| true -> begin
"*"
end
| uu____17342 -> begin
(

let uu____17343 = (FStar_Ident.text_of_path p)
in (Prims.strcat (match (b) with
| true -> begin
"+"
end
| uu____17344 -> begin
"-"
end) uu____17343))
end)
end))
in (

let uu____17345 = (

let uu____17348 = (FStar_List.map aux env.proof_ns)
in (FStar_All.pipe_right uu____17348 FStar_List.rev))
in (FStar_All.pipe_right uu____17345 (FStar_String.concat " ")))))


let dummy_solver : solver_t = {init = (fun uu____17363 -> ()); push = (fun uu____17365 -> ()); pop = (fun uu____17367 -> ()); encode_modul = (fun uu____17370 uu____17371 -> ()); encode_sig = (fun uu____17374 uu____17375 -> ()); preprocess = (fun e g -> (

let uu____17381 = (

let uu____17388 = (FStar_Options.peek ())
in ((e), (g), (uu____17388)))
in (uu____17381)::[])); solve = (fun uu____17404 uu____17405 uu____17406 -> ()); finish = (fun uu____17412 -> ()); refresh = (fun uu____17414 -> ())}


let mk_copy : env  ->  env = (fun en -> (

let uu___113_17420 = en
in (

let uu____17421 = (FStar_Util.smap_copy en.gamma_cache)
in (

let uu____17424 = (FStar_Util.smap_copy en.sigtab)
in (

let uu____17427 = (FStar_Syntax_DsEnv.mk_copy en.dsenv)
in {solver = uu___113_17420.solver; range = uu___113_17420.range; curmodule = uu___113_17420.curmodule; gamma = uu___113_17420.gamma; gamma_sig = uu___113_17420.gamma_sig; gamma_cache = uu____17421; modules = uu___113_17420.modules; expected_typ = uu___113_17420.expected_typ; sigtab = uu____17424; is_pattern = uu___113_17420.is_pattern; instantiate_imp = uu___113_17420.instantiate_imp; effects = uu___113_17420.effects; generalize = uu___113_17420.generalize; letrecs = uu___113_17420.letrecs; top_level = uu___113_17420.top_level; check_uvars = uu___113_17420.check_uvars; use_eq = uu___113_17420.use_eq; is_iface = uu___113_17420.is_iface; admit = uu___113_17420.admit; lax = uu___113_17420.lax; lax_universes = uu___113_17420.lax_universes; failhard = uu___113_17420.failhard; nosynth = uu___113_17420.nosynth; tc_term = uu___113_17420.tc_term; type_of = uu___113_17420.type_of; universe_of = uu___113_17420.universe_of; check_type_of = uu___113_17420.check_type_of; use_bv_sorts = uu___113_17420.use_bv_sorts; qtbl_name_and_index = uu___113_17420.qtbl_name_and_index; normalized_eff_names = uu___113_17420.normalized_eff_names; proof_ns = uu___113_17420.proof_ns; synth_hook = uu___113_17420.synth_hook; splice = uu___113_17420.splice; is_native_tactic = uu___113_17420.is_native_tactic; identifier_info = uu___113_17420.identifier_info; tc_hooks = uu___113_17420.tc_hooks; dsenv = uu____17427; dep_graph = uu___113_17420.dep_graph})))))




