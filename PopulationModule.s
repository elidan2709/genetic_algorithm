	.386p
DGROUP	GROUP	_BSS,_DATA
	ASSUME	CS:_CODE,ES:DGROUP,DS:DGROUP,SS:DGROUP

	EXTRN	FPC_PUSHEXCEPTADDR: NEAR
	EXTRN	FPC_SETJMP: NEAR
	EXTRN	U_$SYSTEM_$$_RANDSEED: NEAR
	EXTRN	fpc_dynarray_setlength: NEAR
	EXTRN	ENTITY_$$_INITENTITY$$ENTITYT: NEAR
	EXTRN	fpc_copy_proc: NEAR
	EXTRN	FPC_POPADDRSTACK: NEAR
	EXTRN	FPC_RERAISE: NEAR
	EXTRN	fpc_initialize: NEAR
	EXTRN	fpc_finalize: NEAR
	EXTRN	fpc_addref: NEAR
	EXTRN	fpc_get_output: NEAR
	EXTRN	fpc_write_text_shortstr: NEAR
	EXTRN	FPC_IOCHECK: NEAR
	EXTRN	fpc_write_text_sint: NEAR
	EXTRN	fpc_write_text_char: NEAR
	EXTRN	fpc_writeln_end: NEAR
	EXTRN	fpc_write_end: NEAR
	EXTRN	ENTITY_$$_SCREENPRINTENTITY$ENTITYT: NEAR
	EXTRN	ENTITY_$$_FILEPRINTENTITY$TEXT$ENTITYT: NEAR
	EXTRN	SYSTEM_$$_ASSIGN$TEXT$SHORTSTRING: NEAR
	EXTRN	SYSTEM_$$_APPEND$TEXT: NEAR
	EXTRN	SYSTEM_$$_CLOSE$TEXT: NEAR
	EXTRN	ENTITY_$$_EVALENTITY$ENTITYT$REAL$REAL$$REAL: NEAR
	EXTRN	fpc_write_text_float: NEAR
	EXTRN	MATH_$$_FLOOR$EXTENDED$$LONGINT: NEAR
	EXTRN	SYSTEM_$$_RANDOM$LONGINT$$LONGINT: NEAR
	EXTRN	IMPLEMENTMODULE_$$_CROSSBREED$ENTITYT$ENTITYT$CONFIGT$$ENTITYT: NEAR
	EXTRN	SYSTEM_$$_RANDOM$$EXTENDED: NEAR
	EXTRN	IMPLEMENTMODULE_$$_MUTATE$ENTITYT$SHORTSTRING: NEAR
	EXTRN	ENTITY_$$_SCOREENTITY$ENTITYT$FUNCTIONT$REAL$REAL: NEAR
	EXTRN	INIT_$ENTITY_$$_ENTITYT: NEAR
	EXTRN	RTTI_$ENTITY_$$_ENTITYT: NEAR
	EXTRN	RTTI_$SYSTEM_$$_SMALLINT: NEAR
; Begin asmlist al_begin
; End asmlist al_begin
; Begin asmlist al_stabs
; End asmlist al_stabs
; Begin asmlist al_procedures

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_INITPOPULATION$SMALLINT$$POPULATIONT
POPULATIONMODULE_$$_INITPOPULATION$SMALLINT$$POPULATIONT:
; Temps allocated between ebp-80 and ebp-8
; [PopulationModule.pas]
; [34] begin
		push	ebp
		mov	ebp,esp
		sub	esp,80
		push	ebx
		push	esi
		push	edi
; Var n located in register bx
; Var $result located in register eax
; Var i located in register bx
; Var population located at ebp-8, size=OS_64
		mov	bx,ax
		mov	dword ptr [ebp-80],edx
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		lea	eax,dword ptr [ebp-8]
		call	fpc_initialize
		mov	eax,1
		lea	edx,dword ptr [ebp-44]
		lea	ecx,dword ptr [ebp-20]
		call	FPC_PUSHEXCEPTADDR
		call	FPC_SETJMP
		push	eax
		test	eax,eax
		jne	@@j5
; [36] randseed := 7;
		mov	dword ptr [U_$SYSTEM_$$_RANDSEED],7
; [37] SetLength(population.entities, n);
		movsx	eax,bx
		mov	dword ptr [ebp-52],eax
		lea	eax,dword ptr [ebp-52]
		push	eax
		mov	edx,offset INIT_$POPULATIONMODULE_$$_DEF1
		lea	eax,dword ptr [ebp-8]
		mov	ecx,1
		call	fpc_dynarray_setlength
; [38] population.n := n;
		mov	word ptr [ebp-4],bx
; [40] for i := 0 to n - 1 do
		movsx	ebx,bx
		lea	eax,dword ptr [ebx-1]
		mov	word ptr [ebp-76],ax
		mov	bx,0
		cmp	word ptr [ebp-76],bx
		jl	@@j24
		dec	bx
@@j25:
		inc	bx
; [41] population.entities[i] := InitEntity();
		lea	eax,dword ptr [ebp-72]
		call	ENTITY_$$_INITENTITY$$ENTITYT
		mov	edx,dword ptr [ebp-8]
		movsx	eax,bx
		shl	eax,4
		lea	edi,dword ptr [edx+eax]
		lea	esi,dword ptr [ebp-72]
		mov	ecx,16
		rep	movsb
		cmp	word ptr [ebp-76],bx
		jg	@@j25
@@j24:
; [43] InitPopulation := population;
		mov	ecx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		mov	edx,dword ptr [ebp-80]
		lea	eax,dword ptr [ebp-8]
		call	fpc_copy_proc
@@j5:
		call	FPC_POPADDRSTACK
; [44] end;
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		lea	eax,dword ptr [ebp-8]
		call	fpc_finalize
		pop	eax
		test	eax,eax
		je	@@j6
		call	FPC_RERAISE
@@j6:
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
POPULATIONMODULE_$$_SCREENPRINTPOPULATION$SMALLINT$POPULATIONT:
; Temps allocated between ebp-48 and ebp-4
; [50] begin
		push	ebp
		mov	ebp,esp
		sub	esp,48
		push	ebx
		push	esi
		push	edi
; Var epoch located in register bx
; Var i located in register bx
; Var population located at ebp-4, size=OS_32
		mov	bx,ax
		mov	dword ptr [ebp-4],edx
		mov	esi,dword ptr [ebp-4]
		lea	edi,dword ptr [ebp-12]
		mov	ecx,8
		rep	movsb
		lea	eax,dword ptr [ebp-12]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_addref
		mov	eax,1
		lea	edx,dword ptr [ebp-48]
		lea	ecx,dword ptr [ebp-24]
		call	FPC_PUSHEXCEPTADDR
		call	FPC_SETJMP
		push	eax
		test	eax,eax
		jne	@@j46
; [51] writeln('Epoch ', epoch, ':');
		call	fpc_get_output
		mov	esi,eax
		mov	ecx,offset _$POPULATIONMODULE$_Ld1
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	ecx,bx
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	edx,esi
		mov	cl,58
		mov	eax,0
		call	fpc_write_text_char
		call	FPC_IOCHECK
		mov	eax,esi
		call	fpc_writeln_end
		call	FPC_IOCHECK
; [52] for i := 0 to population.n - 1 do
		movsx	eax,word ptr [ebp-8]
		dec	eax
		mov	di,ax
		mov	bx,0
		cmp	di,bx
		jl	@@j73
		dec	bx
@@j74:
		inc	bx
; [54] write('  ', (i + 1):3, ') ');
		call	fpc_get_output
		mov	esi,eax
		mov	ecx,offset _$POPULATIONMODULE$_Ld2
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	eax,bx
		inc	eax
		mov	ecx,eax
		mov	edx,esi
		mov	eax,3
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	ecx,offset _$POPULATIONMODULE$_Ld3
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		mov	eax,esi
		call	fpc_write_end
		call	FPC_IOCHECK
; [55] ScreenPrintEntity(population.entities[i]);
		mov	edx,dword ptr [ebp-12]
		movsx	eax,bx
		shl	eax,4
		lea	eax,dword ptr [edx+eax]
		call	ENTITY_$$_SCREENPRINTENTITY$ENTITYT
		cmp	di,bx
		jg	@@j74
@@j73:
; [57] writeln;
		call	fpc_get_output
		call	fpc_writeln_end
		call	FPC_IOCHECK
@@j46:
		call	FPC_POPADDRSTACK
; [58] end;
		lea	eax,dword ptr [ebp-12]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_finalize
		pop	eax
		test	eax,eax
		je	@@j47
		call	FPC_RERAISE
@@j47:
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
POPULATIONMODULE_$$_FILEPRINTPOPULATION$SMALLINT$TEXT$POPULATIONT:
; Temps allocated between ebp-52 and ebp-4
; [64] begin
		push	ebp
		mov	ebp,esp
		sub	esp,52
		push	ebx
		push	esi
		push	edi
; Var epoch located in register bx
; Var f located in register eax
; Var i located in register bx
; Var population located at ebp-4, size=OS_32
		mov	bx,ax
		mov	dword ptr [ebp-52],edx
		mov	dword ptr [ebp-4],ecx
		mov	esi,dword ptr [ebp-4]
		lea	edi,dword ptr [ebp-12]
		mov	ecx,8
		rep	movsb
		lea	eax,dword ptr [ebp-12]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_addref
		mov	eax,1
		lea	edx,dword ptr [ebp-48]
		lea	ecx,dword ptr [ebp-24]
		call	FPC_PUSHEXCEPTADDR
		call	FPC_SETJMP
		push	eax
		test	eax,eax
		jne	@@j105
; [65] writeln(f, 'Epoch ', epoch, ':');
		mov	edx,dword ptr [ebp-52]
		mov	ecx,offset _$POPULATIONMODULE$_Ld1
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	ecx,bx
		mov	edx,dword ptr [ebp-52]
		mov	eax,0
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	edx,dword ptr [ebp-52]
		mov	cl,58
		mov	eax,0
		call	fpc_write_text_char
		call	FPC_IOCHECK
		mov	eax,dword ptr [ebp-52]
		call	fpc_writeln_end
		call	FPC_IOCHECK
; [66] for i := 0 to population.n - 1 do
		movsx	eax,word ptr [ebp-8]
		dec	eax
		mov	si,ax
		mov	bx,0
		cmp	si,bx
		jl	@@j130
		dec	bx
@@j131:
		inc	bx
; [68] write(f, '  ', (i + 1):3, ') ');
		mov	edx,dword ptr [ebp-52]
		mov	ecx,offset _$POPULATIONMODULE$_Ld2
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	eax,bx
		inc	eax
		mov	ecx,eax
		mov	edx,dword ptr [ebp-52]
		mov	eax,3
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	edx,dword ptr [ebp-52]
		mov	ecx,offset _$POPULATIONMODULE$_Ld3
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		mov	eax,dword ptr [ebp-52]
		call	fpc_write_end
		call	FPC_IOCHECK
; [69] FilePrintEntity(f, population.entities[i]);
		mov	edx,dword ptr [ebp-12]
		movsx	eax,bx
		shl	eax,4
		lea	edx,dword ptr [edx+eax]
		mov	eax,dword ptr [ebp-52]
		call	ENTITY_$$_FILEPRINTENTITY$TEXT$ENTITYT
		cmp	si,bx
		jg	@@j131
@@j130:
; [71] writeln(f);
		mov	eax,dword ptr [ebp-52]
		call	fpc_writeln_end
		call	FPC_IOCHECK
@@j105:
		call	FPC_POPADDRSTACK
; [72] end;
		lea	eax,dword ptr [ebp-12]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_finalize
		pop	eax
		test	eax,eax
		je	@@j106
		call	FPC_RERAISE
@@j106:
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_PRINTPOPULATION$SMALLINT$POPULATIONT$CONFIGT
POPULATIONMODULE_$$_PRINTPOPULATION$SMALLINT$POPULATIONT$CONFIGT:
; Temps allocated between ebp-2308 and ebp-880
; [80] begin
		push	ebp
		mov	ebp,esp
		sub	esp,2308
		push	ebx
		push	esi
		push	edi
; Var epoch located in register bx
; Var population located at ebp-4, size=OS_32
; Var config located at ebp-8, size=OS_32
; Var f located at ebp-864, size=OS_NO
; Var x located at ebp-872, size=OS_F64
; Var y located at ebp-880, size=OS_F64
		mov	bx,ax
		mov	dword ptr [ebp-4],edx
		mov	dword ptr [ebp-8],ecx
		mov	esi,dword ptr [ebp-4]
		lea	edi,dword ptr [ebp-888]
		mov	ecx,8
		rep	movsb
		mov	esi,dword ptr [ebp-8]
		lea	edi,dword ptr [ebp-2272]
		mov	ecx,1384
		rep	movsb
		lea	eax,dword ptr [ebp-888]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_addref
		mov	eax,1
		lea	edx,dword ptr [ebp-2308]
		lea	ecx,dword ptr [ebp-2284]
		call	FPC_PUSHEXCEPTADDR
		call	FPC_SETJMP
		push	eax
		test	eax,eax
		jne	@@j160
; [81] if config.debug_file <> '' then
		cmp	byte ptr [ebp-1152],0
		je	@@j163
; [83] assign(f, config.debug_file);
		lea	edx,dword ptr [ebp-1152]
		lea	eax,dword ptr [ebp-864]
		call	SYSTEM_$$_ASSIGN$TEXT$SHORTSTRING
; [84] append(f);
		lea	eax,dword ptr [ebp-864]
		call	SYSTEM_$$_APPEND$TEXT
		call	FPC_IOCHECK
; [85] FilePrintPopulation(epoch, f, population);
		lea	ecx,dword ptr [ebp-888]
		lea	edx,dword ptr [ebp-864]
		mov	ax,bx
		call	POPULATIONMODULE_$$_FILEPRINTPOPULATION$SMALLINT$TEXT$POPULATIONT
; [86] close(f);
		lea	eax,dword ptr [ebp-864]
		call	SYSTEM_$$_CLOSE$TEXT
		call	FPC_IOCHECK
; [88] if config.print_screen then
		cmp	byte ptr [ebp-896],0
		je	@@j179
; [89] ScreenPrintPopulation(epoch, population)
		lea	edx,dword ptr [ebp-888]
		mov	ax,bx
		call	POPULATIONMODULE_$$_SCREENPRINTPOPULATION$SMALLINT$POPULATIONT
		jmp	@@j243
@@j179:
; [92] x := EvalEntity(population.entities[0],
		push	dword ptr [ebp-2268]
		push	dword ptr [ebp-2272]
		push	dword ptr [ebp-2260]
		push	dword ptr [ebp-2264]
		mov	eax,dword ptr [ebp-888]
		call	ENTITY_$$_EVALENTITY$ENTITYT$REAL$REAL$$REAL
		fstp	qword ptr [ebp-872]
; [94] y := population.entities[0].score;
		mov	eax,dword ptr [ebp-888]
		lea	edi,dword ptr [ebp-880]
		lea	esi,dword ptr [eax+8]
		mov	ecx,8
		rep	movsb
; [96] writeln('Epoch ', epoch:3, ', x: ',
		call	fpc_get_output
		mov	esi,eax
		mov	ecx,offset _$POPULATIONMODULE$_Ld1
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	ecx,bx
		mov	edx,esi
		mov	eax,3
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	ecx,offset _$POPULATIONMODULE$_Ld4
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		push	esi
; [97] x:0:10, ', y: ', y:0:10);
		fld	qword ptr [ebp-872]
		sub	esp,12
		fstp	tbyte ptr [esp]
		mov	ecx,0
		mov	edx,10
		mov	eax,1
		call	fpc_write_text_float
		call	FPC_IOCHECK
		mov	ecx,offset _$POPULATIONMODULE$_Ld5
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		push	esi
		fld	qword ptr [ebp-880]
		sub	esp,12
		fstp	tbyte ptr [esp]
		mov	ecx,0
		mov	edx,10
		mov	eax,1
		call	fpc_write_text_float
		call	FPC_IOCHECK
		mov	eax,esi
		call	fpc_writeln_end
		call	FPC_IOCHECK
		jmp	@@j243
@@j163:
; [102] x := EvalEntity(population.entities[0], config.left_border,
		push	dword ptr [ebp-2268]
		push	dword ptr [ebp-2272]
		push	dword ptr [ebp-2260]
		push	dword ptr [ebp-2264]
		mov	eax,dword ptr [ebp-888]
		call	ENTITY_$$_EVALENTITY$ENTITYT$REAL$REAL$$REAL
		fstp	qword ptr [ebp-872]
; [104] y := population.entities[0].score;
		mov	eax,dword ptr [ebp-888]
		lea	edi,dword ptr [ebp-880]
		lea	esi,dword ptr [eax+8]
		mov	ecx,8
		rep	movsb
; [106] writeln('Epoch ', epoch:3, ', x: ', x:0:10, ', y: ', y:0:10);
		call	fpc_get_output
		mov	esi,eax
		mov	ecx,offset _$POPULATIONMODULE$_Ld1
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		movsx	ecx,bx
		mov	edx,esi
		mov	eax,3
		call	fpc_write_text_sint
		call	FPC_IOCHECK
		mov	ecx,offset _$POPULATIONMODULE$_Ld4
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		push	esi
		fld	qword ptr [ebp-872]
		sub	esp,12
		fstp	tbyte ptr [esp]
		mov	ecx,0
		mov	edx,10
		mov	eax,1
		call	fpc_write_text_float
		call	FPC_IOCHECK
		mov	ecx,offset _$POPULATIONMODULE$_Ld5
		mov	edx,esi
		mov	eax,0
		call	fpc_write_text_shortstr
		call	FPC_IOCHECK
		push	esi
		fld	qword ptr [ebp-880]
		sub	esp,12
		fstp	tbyte ptr [esp]
		mov	ecx,0
		mov	edx,10
		mov	eax,1
		call	fpc_write_text_float
		call	FPC_IOCHECK
		mov	eax,esi
		call	fpc_writeln_end
		call	FPC_IOCHECK
@@j243:
@@j160:
		call	FPC_POPADDRSTACK
; [108] end;
		lea	eax,dword ptr [ebp-888]
		mov	edx,offset INIT_$POPULATIONMODULE_$$_POPULATIONT
		call	fpc_finalize
		pop	eax
		test	eax,eax
		je	@@j161
		call	FPC_RERAISE
@@j161:
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_CROSSBREEDPOPULATION$POPULATIONT$CONFIGT$SMALLINT
POPULATIONMODULE_$$_CROSSBREEDPOPULATION$POPULATIONT$CONFIGT$SMALLINT:
; Temps allocated between ebp-1456 and ebp-40
; [116] begin
		push	ebp
		mov	ebp,esp
		sub	esp,1456
		push	ebx
		push	esi
		push	edi
; Var population located in register eax
; Var count located in register bx
; Var parents located in register ax
; Var i located in register ax
; Var config located at ebp-4, size=OS_32
; Var parent1 located at ebp-24, size=OS_NO
; Var parent2 located at ebp-40, size=OS_NO
		mov	dword ptr [ebp-1452],eax
		mov	dword ptr [ebp-4],edx
		mov	bx,cx
		mov	esi,dword ptr [ebp-4]
		lea	edi,dword ptr [ebp-1424]
		mov	ecx,1384
		rep	movsb
; [117] parents := floor(count * config.crossing_part);
		movsx	eax,bx
		mov	dword ptr [ebp-4],eax
		fild	dword ptr [ebp-4]
		fmul	qword ptr [ebp-584]
		sub	esp,12
		fstp	tbyte ptr [esp]
		call	MATH_$$_FLOOR$EXTENDED$$LONGINT
; Var parents located in register ax
		mov	word ptr [ebp-1448],ax
; [119] for i := count to population.n - 1 do
		mov	eax,dword ptr [ebp-1452]
		movsx	edx,word ptr [eax+4]
		lea	eax,dword ptr [edx-1]
		mov	word ptr [ebp-1444],ax
; Var i located in register ax
		mov	word ptr [ebp-1456],bx
		mov	ax,word ptr [ebp-1456]
		cmp	word ptr [ebp-1444],ax
		jl	@@j311
		dec	word ptr [ebp-1456]
@@j312:
		inc	word ptr [ebp-1456]
; [121] parent1 := population.entities[random(parents)];
		mov	eax,dword ptr [ebp-1452]
		mov	ebx,dword ptr [eax]
		movsx	eax,word ptr [ebp-1448]
		call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
		shl	eax,4
		lea	edi,dword ptr [ebp-24]
		lea	esi,dword ptr [ebx+eax]
		mov	ecx,16
		rep	movsb
; [122] parent2 := population.entities[random(parents)];
		mov	eax,dword ptr [ebp-1452]
		mov	ebx,dword ptr [eax]
		movsx	eax,word ptr [ebp-1448]
		call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
		shl	eax,4
		lea	edi,dword ptr [ebp-40]
		lea	esi,dword ptr [ebx+eax]
		mov	ecx,16
		rep	movsb
; [124] population.entities[i] := CrossBreed(parent1, parent2, config);
		lea	eax,dword ptr [ebp-1440]
		push	eax
		lea	ecx,dword ptr [ebp-1424]
		lea	edx,dword ptr [ebp-40]
		lea	eax,dword ptr [ebp-24]
		call	IMPLEMENTMODULE_$$_CROSSBREED$ENTITYT$ENTITYT$CONFIGT$$ENTITYT
		mov	eax,dword ptr [ebp-1452]
		mov	edx,dword ptr [eax]
		movsx	eax,word ptr [ebp-1456]
		shl	eax,4
		lea	edi,dword ptr [edx+eax]
		lea	esi,dword ptr [ebp-1440]
		mov	ecx,16
		rep	movsb
		mov	ax,word ptr [ebp-1456]
		cmp	word ptr [ebp-1444],ax
		jg	@@j312
@@j311:
; [126] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_MUTATEPOPULATION$POPULATIONT$CONFIGT
POPULATIONMODULE_$$_MUTATEPOPULATION$POPULATIONT$CONFIGT:
; Temps allocated between esp+4 and esp+1400
; [133] begin
		push	ebx
		push	esi
		push	edi
		sub	esp,1400
; Var population located in register ebx
; Var start located in register di
; Var i located in register di
; Var config located at esp+0, size=OS_32
		mov	ebx,eax
		mov	dword ptr [esp],edx
		mov	esi,dword ptr [esp]
		lea	edi,dword ptr [esp+8]
		mov	ecx,1384
		rep	movsb
; [134] start := round(population.n * config.preserved_high_positions);
		movsx	eax,word ptr [ebx+4]
		mov	dword ptr [esp],eax
		fild	dword ptr [esp]
		fmul	qword ptr [esp+312]
		fistp	qword ptr [esp+1392]
		fwait
; Var start located in register di
		mov	di,word ptr [esp+1392]
; [136] for i := start to population.n - 1 do
		movsx	eax,word ptr [ebx+4]
		lea	esi,dword ptr [eax-1]
; Var i located in register di
		cmp	si,di
		jl	@@j338
		dec	di
@@j339:
		inc	di
; [137] if random < config.variability then
		call	SYSTEM_$$_RANDOM$$EXTENDED
		fld	qword ptr [esp+1120]
		fcompp
		fnstsw	ax
		sahf
		jp	@@j341
		jna	@@j341
; [138] Mutate(population.entities[i], config.mutation_method);
		mov	edx,dword ptr [ebx]
		movsx	eax,di
		shl	eax,4
		lea	eax,dword ptr [edx+eax]
		lea	edx,dword ptr [esp+864]
		call	IMPLEMENTMODULE_$$_MUTATE$ENTITYT$SHORTSTRING
@@j341:
		cmp	si,di
		jg	@@j339
@@j338:
; [139] end;
		add	esp,1400
		pop	edi
		pop	esi
		pop	ebx
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_UNIQUEPOPULATION$POPULATIONT$CONFIGT
POPULATIONMODULE_$$_UNIQUEPOPULATION$POPULATIONT$CONFIGT:
; Temps allocated between esp+4 and esp+1424
; [145] begin
		push	ebx
		push	esi
		push	edi
		sub	esp,1424
; Var population located in register eax
; Var i located in register ax
; Var j located in register ax
; Var config located at esp+0, size=OS_32
		mov	dword ptr [esp+1420],eax
		mov	dword ptr [esp],edx
		mov	esi,dword ptr [esp]
		lea	edi,dword ptr [esp+8]
		mov	ecx,1384
		rep	movsb
; [146] for i := 0 to population.n - 1 do
		mov	edx,dword ptr [esp+1420]
		movsx	eax,word ptr [edx+4]
		dec	eax
		mov	word ptr [esp+1416],ax
; Var i located in register ax
		mov	word ptr [esp+1412],0
		mov	ax,word ptr [esp+1416]
		cmp	ax,word ptr [esp+1412]
		jl	@@j352
		dec	word ptr [esp+1412]
@@j353:
		inc	word ptr [esp+1412]
; [147] for j := i + 1 to population.n - 1 do
		mov	edx,dword ptr [esp+1420]
		movsx	eax,word ptr [edx+4]
		dec	eax
		mov	bx,ax
		movsx	eax,word ptr [esp+1412]
		inc	eax
		mov	word ptr [esp+1408],ax
		cmp	bx,word ptr [esp+1408]
		jl	@@j357
		dec	word ptr [esp+1408]
@@j358:
		inc	word ptr [esp+1408]
		mov	eax,dword ptr [esp+1420]
		mov	edx,dword ptr [eax]
; [148] if population.entities[i].bits =
		movsx	eax,word ptr [esp+1412]
		mov	ecx,eax
		shl	ecx,4
; [149] population.entities[j].bits then
		movsx	eax,word ptr [esp+1408]
		mov	esi,eax
		shl	esi,4
		mov	eax,dword ptr [edx+ecx]
		cmp	eax,dword ptr [edx+esi]
		jne	@@j360
; [150] population.entities[j] := InitEntity();
		lea	eax,dword ptr [esp+1392]
		call	ENTITY_$$_INITENTITY$$ENTITYT
		mov	eax,dword ptr [esp+1420]
		mov	edx,dword ptr [eax]
		movsx	eax,word ptr [esp+1408]
		shl	eax,4
		lea	edi,dword ptr [edx+eax]
		lea	esi,dword ptr [esp+1392]
		mov	ecx,16
		rep	movsb
@@j360:
		cmp	bx,word ptr [esp+1408]
		jg	@@j358
@@j357:
		mov	ax,word ptr [esp+1416]
		cmp	ax,word ptr [esp+1412]
		jg	@@j353
@@j352:
; [151] end;
		add	esp,1424
		pop	edi
		pop	esi
		pop	ebx
		ret
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_SCOREPOPULATION$array_of_ENTITYT$CONFIGT$FUNCTIONT
POPULATIONMODULE_$$_SCOREPOPULATION$array_of_ENTITYT$CONFIGT$FUNCTIONT:
; Temps allocated between ebp-1400 and ebp-4
; [187] begin
		push	ebp
		mov	ebp,esp
		sub	esp,1400
		push	ebx
		push	esi
		push	edi
; Var population located in register eax
; Var f located in register eax
; Var $highPOPULATION located in register edx
; Var i located in register bx
; Var config located at ebp-4, size=OS_32
		mov	dword ptr [ebp-1396],eax
		mov	dword ptr [ebp-4],ecx
		mov	eax,dword ptr [ebp+8]
		mov	dword ptr [ebp-1400],eax
		mov	esi,dword ptr [ebp-4]
		lea	edi,dword ptr [ebp-1392]
		mov	ecx,1384
		rep	movsb
; [188] for i := 0 to length(population) - 1 do
		lea	eax,dword ptr [edx+1]
		dec	eax
		mov	si,ax
; Var i located in register bx
		mov	bx,0
		cmp	si,bx
		jl	@@j372
		dec	bx
@@j373:
		inc	bx
; [189] ScoreEntity(population[i], f,
		push	dword ptr [ebp-1388]
		push	dword ptr [ebp-1392]
		push	dword ptr [ebp-1380]
		push	dword ptr [ebp-1384]
		movsx	eax,bx
		shl	eax,4
		add	eax,dword ptr [ebp-1396]
		mov	edx,dword ptr [ebp-1400]
		call	ENTITY_$$_SCOREENTITY$ENTITYT$FUNCTIONT$REAL$REAL
		cmp	si,bx
		jg	@@j373
@@j372:
; [191] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	4
_CODE		ENDS

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	POPULATIONMODULE_$$_EVALPOPULATION$array_of_ENTITYT$LONGWORD
POPULATIONMODULE_$$_EVALPOPULATION$array_of_ENTITYT$LONGWORD:
; Temps allocated between ebp-28 and ebp-8
; [199] begin
		push	ebp
		mov	ebp,esp
		sub	esp,28
		push	ebx
		push	esi
		push	edi
; Var population located in register eax
; Var len located in register eax
; Var $highPOPULATION located in register edx
; Var i located in register ax
; Var j located in register dx
; Var swap_longint located in register eax
; Var swap_real located at ebp-8, size=OS_F64
		mov	dword ptr [ebp-28],eax
		mov	dword ptr [ebp-24],ecx
; [200] for i := 0 to len - 1 do
		mov	edx,dword ptr [ebp-24]
		lea	eax,dword ptr [edx-1]
		mov	word ptr [ebp-20],ax
; Var i located in register ax
		mov	word ptr [ebp-12],0
		mov	ax,word ptr [ebp-20]
		cmp	ax,word ptr [ebp-12]
		jl	@@j387
		dec	word ptr [ebp-12]
@@j388:
		inc	word ptr [ebp-12]
; [201] for j := i + 1 to len - 1 do
		mov	ecx,dword ptr [ebp-24]
		lea	eax,dword ptr [ecx-1]
		mov	bx,ax
		movsx	eax,word ptr [ebp-12]
		inc	eax
		mov	dx,ax
		cmp	bx,dx
		jl	@@j392
		dec	dx
@@j393:
		inc	dx
; [203] if population[i].score < population[j].score then
		movsx	eax,word ptr [ebp-12]
		mov	ecx,eax
		shl	ecx,4
		movsx	eax,dx
		shl	eax,4
		mov	esi,dword ptr [ebp-28]
		fld	qword ptr [esi+eax+8]
		mov	eax,dword ptr [ebp-28]
		fld	qword ptr [eax+ecx+8]
		fcompp
		fnstsw	ax
		sahf
		jp	@@j395
		jnb	@@j395
; [205] swap_longint := population[i].bits;
		movsx	eax,word ptr [ebp-12]
		mov	ecx,eax
		shl	ecx,4
		mov	eax,dword ptr [ebp-28]
		mov	eax,dword ptr [eax+ecx]
		mov	dword ptr [ebp-16],eax
; [206] population[i].bits := population[j].bits;
		movsx	eax,word ptr [ebp-12]
		mov	ecx,eax
		shl	ecx,4
		movsx	eax,dx
		shl	eax,4
		mov	edi,dword ptr [ebp-28]
		mov	esi,dword ptr [edi+eax]
		mov	eax,dword ptr [ebp-28]
		mov	dword ptr [eax+ecx],esi
; [207] population[j].bits := swap_longint;
		movsx	eax,dx
		shl	eax,4
		mov	esi,dword ptr [ebp-16]
		mov	ecx,dword ptr [ebp-28]
		mov	dword ptr [ecx+eax],esi
; [208] swap_real := population[i].score;
		movsx	eax,word ptr [ebp-12]
		shl	eax,4
		lea	edi,dword ptr [ebp-8]
		mov	ecx,dword ptr [ebp-28]
		lea	esi,dword ptr [ecx+eax+8]
		mov	ecx,8
		rep	movsb
; [209] population[i].score := population[j].score;
		movsx	eax,word ptr [ebp-12]
		mov	ecx,eax
		shl	ecx,4
		movsx	eax,dx
		mov	esi,eax
		shl	esi,4
		mov	eax,dword ptr [ebp-28]
		lea	edi,dword ptr [eax+ecx+8]
		mov	eax,dword ptr [ebp-28]
		lea	esi,dword ptr [eax+esi+8]
		mov	ecx,8
		rep	movsb
; [210] population[j].score := swap_real;
		movsx	eax,dx
		shl	eax,4
		mov	ecx,dword ptr [ebp-28]
		lea	edi,dword ptr [ecx+eax+8]
		lea	esi,dword ptr [ebp-8]
		mov	ecx,8
		rep	movsb
@@j395:
		cmp	bx,dx
		jg	@@j393
@@j392:
		mov	ax,word ptr [ebp-20]
		cmp	ax,word ptr [ebp-12]
		jg	@@j388
@@j387:
; [213] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret
; End asmlist al_procedures
; Begin asmlist al_globals
; End asmlist al_globals
; Begin asmlist al_const
; End asmlist al_const
; Begin asmlist al_typedconsts
_CODE		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
_$POPULATIONMODULE$_Ld1		DB	6,"Epoch ",0
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
_$POPULATIONMODULE$_Ld2		DB	2,"  ",0
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
_$POPULATIONMODULE$_Ld3		DB	2,") ",0
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
_$POPULATIONMODULE$_Ld4		DB	5,", x: ",0
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
_$POPULATIONMODULE$_Ld5		DB	5,", y: ",0
; End asmlist al_typedconsts
; Begin asmlist al_rotypedconsts
; End asmlist al_rotypedconsts
; Begin asmlist al_threadvars
; End asmlist al_threadvars
; Begin asmlist al_imports
; End asmlist al_imports
; Begin asmlist al_exports
; End asmlist al_exports
; Begin asmlist al_resources
; End asmlist al_resources
; Begin asmlist al_rtti
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
	PUBLIC	INIT_$POPULATIONMODULE_$$_DEF1
INIT_$POPULATIONMODULE_$$_DEF1	DB	21
		DB	0
	DD	16,INIT_$ENTITY_$$_ENTITYT,-1,0
	DB	16
		DB	"PopulationModule"
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
	PUBLIC	INIT_$POPULATIONMODULE_$$_POPULATIONT
INIT_$POPULATIONMODULE_$$_POPULATIONT	DB	13,11
		DB	"PopulationT"
	DD	8,1,INIT_$POPULATIONMODULE_$$_DEF1,0
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
	PUBLIC	RTTI_$POPULATIONMODULE_$$_DEF1
RTTI_$POPULATIONMODULE_$$_DEF1	DB	21
		DB	0
	DD	16,RTTI_$ENTITY_$$_ENTITYT,-1,0
	DB	16
		DB	"PopulationModule"
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
	PUBLIC	RTTI_$POPULATIONMODULE_$$_POPULATIONT
RTTI_$POPULATIONMODULE_$$_POPULATIONT	DB	13,11
		DB	"PopulationT"
	DD	8,2,RTTI_$POPULATIONMODULE_$$_DEF1,0,RTTI_$SYSTEM_$$_SMALLINT,4
_DATA		ENDS

_DATA		SEGMENT	DWORD PUBLIC USE32 'DATA'
	ALIGN 4
	PUBLIC	RTTI_$POPULATIONMODULE_$$_DEF29
RTTI_$POPULATIONMODULE_$$_DEF29	DB	9
		DB	0
	DW	65001
; End asmlist al_rtti
; Begin asmlist al_dwarf_frame
; End asmlist al_dwarf_frame
; Begin asmlist al_dwarf_info
; End asmlist al_dwarf_info
; Begin asmlist al_dwarf_abbrev
; End asmlist al_dwarf_abbrev
; Begin asmlist al_dwarf_line
; End asmlist al_dwarf_line
; Begin asmlist al_picdata
; End asmlist al_picdata
; Begin asmlist al_indirectpicdata
; End asmlist al_indirectpicdata
; Begin asmlist al_resourcestrings
; End asmlist al_resourcestrings
; Begin asmlist al_objc_data
; End asmlist al_objc_data
; Begin asmlist al_objc_pools
; End asmlist al_objc_pools
; Begin asmlist al_end
; End asmlist al_end
_DATA		ENDS
	END

