
open Prims

type z3_result =
(FStar_SMTEncoding_Z3.unsat_core, FStar_SMTEncoding_Term.error_labels) FStar_Util.either


type hint_stat =
{hint : FStar_Util.hint Prims.option; replay_result : z3_result; elapsed_time : Prims.int; source_location : FStar_Range.range}


let is_Mkhint_stat : hint_stat  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkhint_stat"))))


type hint_stats_t =
hint_stat Prims.list


let recorded_hints : FStar_Util.hints Prims.option FStar_ST.ref = (FStar_Util.mk_ref None)


let replaying_hints : FStar_Util.hints Prims.option FStar_ST.ref = (FStar_Util.mk_ref None)


let hint_stats : hint_stat Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let format_hints_file_name : Prims.string  ->  Prims.string = (fun src_filename -> (FStar_Util.format1 "%s.hints" src_filename))


let initialize_hints_db = (fun src_filename force_record -> (

let _86_10 = (FStar_ST.op_Colon_Equals hint_stats [])
in (

let _86_12 = if (FStar_Options.record_hints ()) then begin
(FStar_ST.op_Colon_Equals recorded_hints (Some ([])))
end else begin
()
end
in if (FStar_Options.use_hints ()) then begin
(

let norm_src_filename = (FStar_Util.normalize_file_path src_filename)
in (

let val_filename = (format_hints_file_name norm_src_filename)
in (match ((FStar_Util.read_hints val_filename)) with
| Some (hints) -> begin
(

let expected_digest = (FStar_Util.digest_of_file norm_src_filename)
in (

let _86_19 = if (FStar_Options.hint_info ()) then begin
if (hints.FStar_Util.module_digest = expected_digest) then begin
(FStar_Util.print1 "(%s) digest is valid; using hints db.\n" norm_src_filename)
end else begin
(FStar_Util.print1 "(%s) digest is invalid; using potentially stale hints\n" norm_src_filename)
end
end else begin
()
end
in (FStar_ST.op_Colon_Equals replaying_hints (Some (hints.FStar_Util.hints)))))
end
| None -> begin
if (FStar_Options.hint_info ()) then begin
(FStar_Util.print1 "(%s) Unable to read hints db.\n" norm_src_filename)
end else begin
()
end
end)))
end else begin
()
end)))


let finalize_hints_db : Prims.string  ->  Prims.unit = (fun src_filename -> (

let _86_26 = if (FStar_Options.record_hints ()) then begin
(

let hints = (let _178_20 = (FStar_ST.read recorded_hints)
in (FStar_Option.get _178_20))
in (

let hints_db = (let _178_21 = (FStar_Util.digest_of_file src_filename)
in {FStar_Util.module_digest = _178_21; FStar_Util.hints = hints})
in (

let hints_file_name = (format_hints_file_name src_filename)
in (FStar_Util.write_hints hints_file_name hints_db))))
end else begin
()
end
in (

let _86_34 = if (FStar_Options.hint_info ()) then begin
(

let stats = (let _178_22 = (FStar_ST.read hint_stats)
in (FStar_All.pipe_right _178_22 FStar_List.rev))
in (FStar_All.pipe_right stats (FStar_List.iter (fun s -> (match (s.replay_result) with
| FStar_Util.Inl (_unsat_core) -> begin
(let _178_25 = (FStar_Range.string_of_range s.source_location)
in (let _178_24 = (FStar_Util.string_of_int s.elapsed_time)
in (FStar_Util.print2 "Hint-info (%s): Replay succeeded in %s milliseconds\n" _178_25 _178_24)))
end
| FStar_Util.Inr (_error) -> begin
(let _178_27 = (FStar_Range.string_of_range s.source_location)
in (let _178_26 = (FStar_Util.string_of_int s.elapsed_time)
in (FStar_Util.print2 "Hint-info (%s): Replay failed in %s milliseconds\n" _178_27 _178_26)))
end)))))
end else begin
()
end
in (

let _86_36 = (FStar_ST.op_Colon_Equals recorded_hints None)
in (

let _86_38 = (FStar_ST.op_Colon_Equals replaying_hints None)
in (FStar_ST.op_Colon_Equals hint_stats []))))))


let with_hints_db = (fun fname f -> (

let _86_42 = (initialize_hints_db fname false)
in (

let result = (f ())
in (

let _86_45 = (finalize_hints_db fname)
in result))))


let next_hint : Prims.unit  ->  FStar_Util.hint Prims.option = (fun _86_47 -> (match (()) with
| () -> begin
(match ((FStar_ST.read replaying_hints)) with
| Some ((hd)::tl) -> begin
(

let _86_52 = (FStar_ST.op_Colon_Equals replaying_hints (Some (tl)))
in hd)
end
| _86_55 -> begin
None
end)
end))


let record_hint : FStar_Util.hint Prims.option  ->  Prims.unit = (fun hint -> (

let hint = (match (hint) with
| None -> begin
None
end
| Some (h) -> begin
Some ((

let _86_60 = h
in {FStar_Util.fuel = _86_60.FStar_Util.fuel; FStar_Util.ifuel = _86_60.FStar_Util.ifuel; FStar_Util.unsat_core = _86_60.FStar_Util.unsat_core; FStar_Util.query_elapsed_time = 0}))
end)
in (match ((FStar_ST.read recorded_hints)) with
| Some (l) -> begin
(FStar_ST.op_Colon_Equals recorded_hints (Some ((FStar_List.append l ((hint)::[])))))
end
| _86_66 -> begin
()
end)))


let record_hint_stat : FStar_Util.hint Prims.option  ->  z3_result  ->  Prims.int  ->  FStar_Range.range  ->  Prims.unit = (fun h res time r -> (

let s = {hint = h; replay_result = res; elapsed_time = time; source_location = r}
in (let _178_46 = (let _178_45 = (FStar_ST.read hint_stats)
in (s)::_178_45)
in (FStar_ST.op_Colon_Equals hint_stats _178_46))))


let ask_and_report_errors : FStar_TypeChecker_Env.env  ->  Prims.bool  ->  ((FStar_SMTEncoding_Z3.label * FStar_SMTEncoding_Term.sort) * Prims.string * FStar_Int64.int64) Prims.list  ->  FStar_SMTEncoding_Term.decl Prims.list  ->  FStar_SMTEncoding_Term.decl  ->  FStar_SMTEncoding_Term.decl Prims.list  ->  Prims.unit = (fun env use_fresh_z3_context all_labels prefix query suffix -> (

let _86_78 = (FStar_SMTEncoding_Z3.giveZ3 prefix)
in (

let minimum_workable_fuel = (FStar_Util.mk_ref None)
in (

let set_minimum_workable_fuel = (fun f _86_1 -> (match (_86_1) with
| [] -> begin
()
end
| errs -> begin
(match ((FStar_ST.read minimum_workable_fuel)) with
| Some (_86_87) -> begin
()
end
| None -> begin
(FStar_ST.op_Colon_Equals minimum_workable_fuel (Some ((f, errs))))
end)
end))
in (

let with_fuel = (fun label_assumptions p _86_96 -> (match (_86_96) with
| (n, i, timeout_ms) -> begin
(let _178_96 = (let _178_95 = (let _178_93 = (let _178_92 = (let _178_87 = (let _178_86 = (let _178_71 = (let _178_70 = (FStar_Util.string_of_int n)
in (let _178_69 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "<fuel=\'%s\' ifuel=\'%s\'>" _178_70 _178_69)))
in FStar_SMTEncoding_Term.Caption (_178_71))
in (let _178_85 = (let _178_84 = (let _178_76 = (let _178_75 = (let _178_74 = (let _178_73 = (FStar_SMTEncoding_Term.mkApp ("MaxFuel", []))
in (let _178_72 = (FStar_SMTEncoding_Term.n_fuel n)
in (_178_73, _178_72)))
in (FStar_SMTEncoding_Term.mkEq _178_74))
in (_178_75, None, None))
in FStar_SMTEncoding_Term.Assume (_178_76))
in (let _178_83 = (let _178_82 = (let _178_81 = (let _178_80 = (let _178_79 = (let _178_78 = (FStar_SMTEncoding_Term.mkApp ("MaxIFuel", []))
in (let _178_77 = (FStar_SMTEncoding_Term.n_fuel i)
in (_178_78, _178_77)))
in (FStar_SMTEncoding_Term.mkEq _178_79))
in (_178_80, None, None))
in FStar_SMTEncoding_Term.Assume (_178_81))
in (_178_82)::(p)::[])
in (_178_84)::_178_83))
in (_178_86)::_178_85))
in (FStar_List.append _178_87 label_assumptions))
in (let _178_91 = (let _178_90 = (let _178_89 = (let _178_88 = (FStar_Util.string_of_int timeout_ms)
in ("timeout", _178_88))
in FStar_SMTEncoding_Term.SetOption (_178_89))
in (_178_90)::[])
in (FStar_List.append _178_92 _178_91)))
in (FStar_List.append _178_93 ((FStar_SMTEncoding_Term.CheckSat)::[])))
in (let _178_94 = if (FStar_Options.record_hints ()) then begin
(FStar_SMTEncoding_Term.GetUnsatCore)::[]
end else begin
[]
end
in (FStar_List.append _178_95 _178_94)))
in (FStar_List.append _178_96 suffix))
end))
in (

let check = (fun p -> (

let default_timeout = ((FStar_Options.z3_timeout ()) * 1000)
in (

let default_initial_config = (let _178_100 = (FStar_Options.initial_fuel ())
in (let _178_99 = (FStar_Options.initial_ifuel ())
in (_178_100, _178_99, default_timeout)))
in (

let hint_opt = (next_hint ())
in (

let _86_110 = (match (hint_opt) with
| None -> begin
(None, default_initial_config)
end
| Some (hint) -> begin
(

let _86_107 = if (FStar_Option.isSome hint.FStar_Util.unsat_core) then begin
(hint.FStar_Util.unsat_core, default_timeout)
end else begin
(None, (60 * 1000))
end
in (match (_86_107) with
| (core, timeout) -> begin
(core, (hint.FStar_Util.fuel, hint.FStar_Util.ifuel, timeout))
end))
end)
in (match (_86_110) with
| (unsat_core, initial_config) -> begin
(

let alt_configs = (let _178_121 = (let _178_120 = if ((default_initial_config <> initial_config) || (FStar_Option.isSome unsat_core)) then begin
(default_initial_config)::[]
end else begin
[]
end
in (let _178_119 = (let _178_118 = if ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ())) then begin
(let _178_103 = (let _178_102 = (FStar_Options.initial_fuel ())
in (let _178_101 = (FStar_Options.max_ifuel ())
in (_178_102, _178_101, default_timeout)))
in (_178_103)::[])
end else begin
[]
end
in (let _178_117 = (let _178_116 = if (((FStar_Options.max_fuel ()) / 2) > (FStar_Options.initial_fuel ())) then begin
(let _178_106 = (let _178_105 = ((FStar_Options.max_fuel ()) / 2)
in (let _178_104 = (FStar_Options.max_ifuel ())
in (_178_105, _178_104, default_timeout)))
in (_178_106)::[])
end else begin
[]
end
in (let _178_115 = (let _178_114 = if (((FStar_Options.max_fuel ()) > (FStar_Options.initial_fuel ())) && ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ()))) then begin
(let _178_109 = (let _178_108 = (FStar_Options.max_fuel ())
in (let _178_107 = (FStar_Options.max_ifuel ())
in (_178_108, _178_107, default_timeout)))
in (_178_109)::[])
end else begin
[]
end
in (let _178_113 = (let _178_112 = if ((FStar_Options.min_fuel ()) < (FStar_Options.initial_fuel ())) then begin
(let _178_111 = (let _178_110 = (FStar_Options.min_fuel ())
in (_178_110, 1, default_timeout))
in (_178_111)::[])
end else begin
[]
end
in (_178_112)::[])
in (_178_114)::_178_113))
in (_178_116)::_178_115))
in (_178_118)::_178_117))
in (_178_120)::_178_119))
in (FStar_List.flatten _178_121))
in (

let report = (fun p errs -> (

let errs = if ((FStar_Options.detail_errors ()) && ((FStar_Options.n_cores ()) = 1)) then begin
(

let _86_122 = (match ((FStar_ST.read minimum_workable_fuel)) with
| Some (f, errs) -> begin
(f, errs)
end
| None -> begin
(let _178_127 = (let _178_126 = (FStar_Options.min_fuel ())
in (_178_126, 1, default_timeout))
in (_178_127, errs))
end)
in (match (_86_122) with
| (min_fuel, potential_errors) -> begin
(

let ask_z3 = (fun label_assumptions -> (

let res = (FStar_Util.mk_ref None)
in (

let _86_127 = (let _178_131 = (with_fuel label_assumptions p min_fuel)
in (FStar_SMTEncoding_Z3.ask use_fresh_z3_context None all_labels _178_131 (fun r -> (FStar_ST.op_Colon_Equals res (Some (r))))))
in (let _178_132 = (FStar_ST.read res)
in (FStar_Option.get _178_132)))))
in (FStar_SMTEncoding_ErrorReporting.detail_errors all_labels errs ask_z3))
end))
end else begin
errs
end
in (

let errs = (match (errs) with
| [] -> begin
((("", FStar_SMTEncoding_Term.Term_sort), "Unknown assertion failed", FStar_Range.dummyRange))::[]
end
| _86_132 -> begin
errs
end)
in (

let _86_134 = (record_hint None)
in (

let _86_136 = if (FStar_Options.print_fuels ()) then begin
(let _178_138 = (let _178_133 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Range.string_of_range _178_133))
in (let _178_137 = (let _178_134 = (FStar_Options.max_fuel ())
in (FStar_All.pipe_right _178_134 FStar_Util.string_of_int))
in (let _178_136 = (let _178_135 = (FStar_Options.max_ifuel ())
in (FStar_All.pipe_right _178_135 FStar_Util.string_of_int))
in (FStar_Util.print3 "(%s) Query failed with maximum fuel %s and ifuel %s\n" _178_138 _178_137 _178_136))))
end else begin
()
end
in (

let _86_143 = (let _178_140 = (FStar_All.pipe_right errs (FStar_List.map (fun _86_142 -> (match (_86_142) with
| (_86_139, x, y) -> begin
(x, y)
end))))
in (FStar_TypeChecker_Errors.add_errors env _178_140))
in if (FStar_Options.detail_errors ()) then begin
(Prims.raise (FStar_Syntax_Syntax.Err ("Detailed error report follows\n")))
end else begin
()
end))))))
in (

let use_errors = (fun errs result -> (match ((errs, result)) with
| (([], _)) | ((_, FStar_Util.Inl (_))) -> begin
result
end
| (_86_159, FStar_Util.Inr (_86_161)) -> begin
FStar_Util.Inr (errs)
end))
in (

let rec try_alt_configs = (fun prev_f p errs cfgs -> (

let _86_170 = (set_minimum_workable_fuel prev_f errs)
in (match (cfgs) with
| [] -> begin
(report p errs)
end
| (mi)::[] -> begin
(match (errs) with
| [] -> begin
(let _178_158 = (with_fuel [] p mi)
in (FStar_SMTEncoding_Z3.ask use_fresh_z3_context None all_labels _178_158 (cb false mi p [])))
end
| _86_177 -> begin
(

let _86_178 = (set_minimum_workable_fuel prev_f errs)
in (report p errs))
end)
end
| (mi)::tl -> begin
(let _178_160 = (with_fuel [] p mi)
in (FStar_SMTEncoding_Z3.ask use_fresh_z3_context None all_labels _178_160 (fun _86_185 -> (match (_86_185) with
| (result, elapsed_time) -> begin
(cb false mi p tl ((use_errors errs result), elapsed_time))
end))))
end)))
and cb = (fun used_hint _86_190 p alt _86_195 -> (match ((_86_190, _86_195)) with
| ((prev_fuel, prev_ifuel, timeout), (result, elapsed_time)) -> begin
(

let _86_198 = if used_hint then begin
(

let _86_196 = (FStar_SMTEncoding_Z3.refresh ())
in (let _178_166 = (FStar_TypeChecker_Env.get_range env)
in (record_hint_stat hint_opt result elapsed_time _178_166)))
end else begin
()
end
in (match (result) with
| FStar_Util.Inl (unsat_core) -> begin
(

let hint = {FStar_Util.fuel = prev_fuel; FStar_Util.ifuel = prev_ifuel; FStar_Util.unsat_core = unsat_core; FStar_Util.query_elapsed_time = elapsed_time}
in (

let _86_203 = (record_hint (Some (hint)))
in if (FStar_Options.print_fuels ()) then begin
(let _178_171 = (let _178_167 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Range.string_of_range _178_167))
in (let _178_170 = (FStar_Util.string_of_int elapsed_time)
in (let _178_169 = (FStar_Util.string_of_int prev_fuel)
in (let _178_168 = (FStar_Util.string_of_int prev_ifuel)
in (FStar_Util.print4 "(%s) Query succeeded in %s milliseconds with fuel %s and ifuel %s\n" _178_171 _178_170 _178_169 _178_168)))))
end else begin
()
end))
end
| FStar_Util.Inr (errs) -> begin
(

let _86_207 = if (FStar_Options.print_fuels ()) then begin
(let _178_176 = (let _178_172 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Range.string_of_range _178_172))
in (let _178_175 = (FStar_Util.string_of_int elapsed_time)
in (let _178_174 = (FStar_Util.string_of_int prev_fuel)
in (let _178_173 = (FStar_Util.string_of_int prev_ifuel)
in (FStar_Util.print4 "(%s) Query failed in %s milliseconds with fuel %s and ifuel %s ... retrying \n" _178_176 _178_175 _178_174 _178_173)))))
end else begin
()
end
in (try_alt_configs (prev_fuel, prev_ifuel, timeout) p errs alt))
end))
end))
in (

let _86_209 = if (FStar_Option.isSome unsat_core) then begin
(FStar_SMTEncoding_Z3.refresh ())
end else begin
()
end
in (let _178_179 = (with_fuel [] p initial_config)
in (let _178_178 = (let _178_177 = (FStar_Option.isSome unsat_core)
in (cb _178_177 initial_config p alt_configs))
in (FStar_SMTEncoding_Z3.ask use_fresh_z3_context unsat_core all_labels _178_179 _178_178))))))))
end))))))
in (

let process_query = (fun q -> if ((FStar_Options.split_cases ()) > 0) then begin
(

let _86_215 = (let _178_185 = (FStar_Options.split_cases ())
in (FStar_SMTEncoding_SplitQueryCases.can_handle_query _178_185 q))
in (match (_86_215) with
| (b, cb) -> begin
if b then begin
(FStar_SMTEncoding_SplitQueryCases.handle_query cb check)
end else begin
(check q)
end
end))
end else begin
(check q)
end)
in if (FStar_Options.admit_smt_queries ()) then begin
()
end else begin
(process_query query)
end)))))))


let solve : (Prims.unit  ->  Prims.string) Prims.option  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  Prims.unit = (fun use_env_msg tcenv q -> (

let _86_219 = (let _178_204 = (let _178_203 = (let _178_202 = (FStar_TypeChecker_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _178_202))
in (FStar_Util.format1 "Starting query at %s" _178_203))
in (FStar_SMTEncoding_Encode.push _178_204))
in (

let _86_225 = (FStar_SMTEncoding_Encode.encode_query use_env_msg tcenv q)
in (match (_86_225) with
| (prefix, labels, qry, suffix) -> begin
(

let pop = (fun _86_227 -> (match (()) with
| () -> begin
(let _178_209 = (let _178_208 = (let _178_207 = (FStar_TypeChecker_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _178_207))
in (FStar_Util.format1 "Ending query at %s" _178_208))
in (FStar_SMTEncoding_Encode.pop _178_209))
end))
in (match (qry) with
| FStar_SMTEncoding_Term.Assume ({FStar_SMTEncoding_Term.tm = FStar_SMTEncoding_Term.App (FStar_SMTEncoding_Term.False, _86_234); FStar_SMTEncoding_Term.hash = _86_231; FStar_SMTEncoding_Term.freevars = _86_229}, _86_239, _86_241) -> begin
(

let _86_244 = (pop ())
in ())
end
| _86_247 when tcenv.FStar_TypeChecker_Env.admit -> begin
(

let _86_248 = (pop ())
in ())
end
| FStar_SMTEncoding_Term.Assume (q, _86_252, _86_254) -> begin
(

let _86_257 = (ask_and_report_errors tcenv false labels prefix qry suffix)
in (pop ()))
end
| _86_260 -> begin
(FStar_All.failwith "Impossible")
end))
end))))


let solver : FStar_TypeChecker_Env.solver_t = {FStar_TypeChecker_Env.init = FStar_SMTEncoding_Encode.init; FStar_TypeChecker_Env.push = FStar_SMTEncoding_Encode.push; FStar_TypeChecker_Env.pop = FStar_SMTEncoding_Encode.pop; FStar_TypeChecker_Env.mark = FStar_SMTEncoding_Encode.mark; FStar_TypeChecker_Env.reset_mark = FStar_SMTEncoding_Encode.reset_mark; FStar_TypeChecker_Env.commit_mark = FStar_SMTEncoding_Encode.commit_mark; FStar_TypeChecker_Env.encode_modul = FStar_SMTEncoding_Encode.encode_modul; FStar_TypeChecker_Env.encode_sig = FStar_SMTEncoding_Encode.encode_sig; FStar_TypeChecker_Env.solve = solve; FStar_TypeChecker_Env.is_trivial = FStar_SMTEncoding_Encode.is_trivial; FStar_TypeChecker_Env.finish = FStar_SMTEncoding_Z3.finish; FStar_TypeChecker_Env.refresh = FStar_SMTEncoding_Z3.refresh}


let dummy : FStar_TypeChecker_Env.solver_t = {FStar_TypeChecker_Env.init = (fun _86_261 -> ()); FStar_TypeChecker_Env.push = (fun _86_263 -> ()); FStar_TypeChecker_Env.pop = (fun _86_265 -> ()); FStar_TypeChecker_Env.mark = (fun _86_267 -> ()); FStar_TypeChecker_Env.reset_mark = (fun _86_269 -> ()); FStar_TypeChecker_Env.commit_mark = (fun _86_271 -> ()); FStar_TypeChecker_Env.encode_modul = (fun _86_273 _86_275 -> ()); FStar_TypeChecker_Env.encode_sig = (fun _86_277 _86_279 -> ()); FStar_TypeChecker_Env.solve = (fun _86_281 _86_283 _86_285 -> ()); FStar_TypeChecker_Env.is_trivial = (fun _86_287 _86_289 -> false); FStar_TypeChecker_Env.finish = (fun _86_291 -> ()); FStar_TypeChecker_Env.refresh = (fun _86_292 -> ())}




