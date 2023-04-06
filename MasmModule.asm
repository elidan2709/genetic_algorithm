.686
.model flat

.data
variability DT 5.00000000000000000000e-0001 ; вещественная константа для универсального скрещивания

.code
	extern	SYSTEM_$$_RANDOM$LONGINT$$LONGINT: NEAR ; рандом
	extern	SYSTEM_$$_RANDOM$$EXTENDED: NEAR ; рандом
	extern	BITOPERATIONS_$$_INVERSEBIT$ENTITYT$SMALLINT: NEAR 			; \					поменять бит на противоположный
	extern	BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT: NEAR	 ; | битовые операции            взять бит
	extern	BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT: NEAR		; /                 установить бит


public swap_mut ; \               поменять 2 бита местами
public rand_mut ;  | мутации                  заменить случайный бит на противоположный    
public rev_mut  ; /               поменять местами участок битов  
public o_p_crbd  ; \              одноточечное скрещивание
public t_p_crbd  ;  | скрещивания двуточечное скрещивание
public univ_crbd ;  |             универсальное скрещивание 
public unif_crbd ; /			  однородное скрещивание
public sort ; сортировка

swap_mut proc
	push ebp
	mov	ebp, esp
	sub	esp, 4
	push ebx
	push esi
	push edi

	mov	eax, dword ptr [ebp+8]
	mov	dword ptr [ebp-4], eax

	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	bx, ax
	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	si, ax
	mov	eax, dword ptr [ebp-4]
	mov	dx, bx
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ;находим первый бит
	mov	di, ax
	mov	eax, dword ptr [ebp-4]
	mov	dx, si
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ;находим второй бит
	mov	dx, ax

	mov	eax, dword ptr [ebp-4]
	mov	cx, bx
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT ; устанавливаем бит

	mov	eax, dword ptr [ebp-4]
	mov	cx, si
	mov	dx, di
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT ; устанавливаем бит

	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	4
swap_mut endp

rand_mut proc
	push ebp
	mov	ebp, esp
	push ebx

	mov	ebx, dword ptr [ebp+8]

	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	mov	edx, eax
	mov	eax, ebx

	call BITOPERATIONS_$$_INVERSEBIT$ENTITYT$SMALLINT ; меняем бит

	pop	ebx
	leave
	ret	4
rand_mut endp

rev_mut proc
	push ebp
	mov	ebp, esp
	sub	esp, 8
	push ebx
	push esi
	push edi

	mov	eax, dword ptr [ebp+8]
	mov	dword ptr [ebp-8], eax

	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT ; получаем рандомный бит

	mov	bx, ax

	mov	si, 29
	jmp	Check
Cycle:

	mov	eax, dword ptr [ebp-8]
	mov	dx, bx
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; меняем биты местами
	mov	word ptr [ebp-4], ax

	mov	eax, dword ptr [ebp-8]
	mov	dx, si
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; меняем биты местами
	mov	di, ax

	mov	eax, dword ptr [ebp-8]
	mov	cx, si
	mov	dx, word ptr [ebp-4]
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT ; устанавливаем биты

	mov	eax, dword ptr [ebp-8]
	mov	cx, bx
	mov	dx, di
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT ; устанавливаем биты

	inc	bx
	dec	si
Check:
	cmp	bx, si
	jl Cycle 

	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	4
rev_mut endp

o_p_crbd proc
	push ebp
	mov	ebp, esp
	sub	esp, 20
	push ebx
	push esi
	push edi

	mov	eax, dword ptr [ebp+8]
	mov	dword ptr [ebp-20], eax

	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT ; получаем рандомный бит

	mov	di, ax

	mov	bx, 0
	dec	bx
Check:
	inc	bx
	cmp	bx, di 
	jnl	After

Before:
	mov	dx, bx
	lea	eax, dword ptr [ebp+12]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; берём бит первой особи
	mov	si, ax
	jmp	CrossBreed

After:
	mov	dx, bx
	lea	eax, dword ptr [ebp+28]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; берём бит второй особи
	mov	si, ax

CrossBreed:
	mov	cx, bx
	mov	dx, si
	lea	eax, dword ptr [ebp-16]
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT
	cmp	bx, 29
	jl Check

	mov	edi, dword ptr [ebp-20] ; получение особи
	lea	esi, dword ptr [ebp-16]
	mov	ecx, 16
	rep	movsb

	pop	edi
	pop	esi
	pop	ebx
	leave
	ret	36
o_p_crbd endp

t_p_crbd proc
	push ebp
	mov	ebp, esp
	sub	esp, 24
	push ebx
	push esi
	push edi

	mov	eax, dword ptr [ebp+8]
	mov	dword ptr [ebp-24], eax

	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT ; получаем рандомный первый бит

	mov	word ptr [ebp-20], ax
	mov	eax, 30
	call SYSTEM_$$_RANDOM$LONGINT$$LONGINT ; получаем рандомный второй бит

	mov	di, ax
	cmp	word ptr [ebp-20], di ; первый бит правее второго
	jng	Continue
	mov	ax, word ptr [ebp-20]
	mov	word ptr [ebp-20], di ; меняем местами
	mov	di, ax

Continue:
	mov	bx, 0
	dec	bx
Cycle:
	inc	bx
	cmp	bx, word ptr [ebp-20] ; проверка счётчика
	jl Other

	cmp	bx, di
	jng	Between

Other:
	mov	dx, bx
	lea	eax, dword ptr [ebp+12]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; берём бит первой особи
	mov	si, ax
	jmp CrossBreed

Between:
	mov	dx, bx
	lea	eax, dword ptr [ebp+28]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; берём бит второй особи
	mov	si, ax

CrossBreed:
	mov	cx, bx
	mov	dx, si
	lea	eax, dword ptr [ebp-16]
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT
	cmp	bx, 29
	jl Cycle

	mov	edi, dword ptr [ebp-24] ; получение особи
	lea	esi, dword ptr [ebp-16]
	mov	ecx, 16
	rep	movsb

	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	36
t_p_crbd endp

univ_crbd proc
	push ebp
	mov	ebp,esp
	sub	esp, 16
	push ebx
	push esi
	push edi

	mov	edi, dword ptr [ebp+8]
	mov	si, 0
	dec	si

Cycle:
	inc	si
	call SYSTEM_$$_RANDOM$$EXTENDED
	fld	qword ptr [ebp+44] ; вероятность больше или меньше
	fcompp
	fnstsw ax
	sahf
	jna	Less_Variability

More_Variability:
	mov	dx, si
	lea	eax, dword ptr [ebp+12]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; бит от второго родителя
	mov	bx, ax
	jmp	CrossBreed

Less_Variability:
	mov	dx, si
	lea	eax, dword ptr [ebp+28]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT ; бит от первого родителя
	mov	bx, ax

CrossBreed:
	mov	cx, si
	mov	dx, bx
	lea	eax, dword ptr [ebp-16]
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT
	cmp	si, 29
	jl Cycle
 
	lea	esi, dword ptr [ebp-16] ; получение особи
	mov	ecx, 16
	rep	movsb

	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	44
univ_crbd endp

unif_crbd proc
	push ebp
	mov	ebp, esp
	sub	esp, 16
	push ebx
	push esi
	push edi

	mov	edi, dword ptr [ebp+8]
	mov	si, 0
	dec	si
Cycle:
	inc	si
	call SYSTEM_$$_RANDOM$$EXTENDED
	fld	tbyte ptr [variability] ; вероятность больше или меньше 
	fcompp
	fnstsw ax
	sahf
	jna	Less_Variability
More_Variability: ; бит от второго родителя
	mov	dx, si
	lea	eax, dword ptr [ebp+12]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT
	mov	bx, ax
	jmp	CrossBreed

Less_Variability: ; бит от первого родителя
	mov	dx, si
	lea	eax, dword ptr [ebp+28]
	call BITOPERATIONS_$$_GETBIT$ENTITYT$SMALLINT$$SMALLINT
	mov	bx, ax

CrossBreed:
	mov	cx, si
	mov	dx, bx
	lea	eax, dword ptr [ebp-16]
	call BITOPERATIONS_$$_SETBIT$ENTITYT$SMALLINT$SMALLINT
	cmp	si, 29
	jl Cycle

	lea	esi, dword ptr [ebp-16] ; получение особи
	mov	ecx, 16
	rep	movsb

	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	36
unif_crbd endp

sort proc
	push ebp
	mov	ebp, esp
	sub	esp, 28
	push ebx
	push esi
	push edi

	mov	eax, dword ptr [ebp+8]
	mov	dword ptr [ebp-28], eax
	mov	eax, dword ptr [ebp+12]
	mov	edx, dword ptr [ebp+16]
	mov	dword ptr [ebp-24], edx

External_Cycle:
	lea	eax, dword ptr [edx-1]
	mov	word ptr [ebp-20], ax

	mov	word ptr [ebp-12], 0
	mov	ax, word ptr [ebp-20]
	cmp	ax, word ptr [ebp-12]
	jl	Epilogue
	dec	word ptr [ebp-12]
Internal_Cycle:
	inc	word ptr [ebp-12]
	mov	eax, dword ptr [ebp-24]
	lea	ecx, dword ptr [eax-1]
	mov	bx, cx
	movsx eax, word ptr [ebp-12]
	inc	eax
	mov	dx, ax
	cmp	bx, dx
	jl Check	
	dec	dx
Swap_Check:
	inc	dx
	movsx eax,word ptr [ebp-12]
	mov	ecx, eax
	shl	ecx, 4
	movsx eax, dx
	shl	eax, 4
	mov	esi, dword ptr [ebp-28]
	fld	qword ptr [esi+eax+8]
	mov	eax,dword ptr [ebp-28]
	fld	qword ptr [eax+ecx+8] ; сравнение элементов
	fcompp
	fnstsw ax
	sahf
	jp	Swap
	jnb	Swap
	movsx	eax, word ptr [ebp-12]
	mov	ecx, eax
	shl	ecx, 4
	mov	eax, dword ptr [ebp-28] ; присвоение временной переменной 
	mov	eax, dword ptr [eax+ecx] ; значения битового представления особи
	mov	dword ptr [ebp-16], eax

	movsx eax, word ptr [ebp-12] ; обмен битовыми значениями
	mov	ecx,eax
	shl	ecx, 4
	movsx eax, dx
	shl	eax, 4
	mov	edi, dword ptr [ebp-28]
	mov	esi, dword ptr [edi+eax]
	mov	eax, dword ptr [ebp-28]
	mov	dword ptr [eax+ecx], esi
	movsx eax, dx
	mov	ecx, eax
	shl	ecx, 4
	mov	esi, dword ptr [ebp-16]
	mov	eax, dword ptr [ebp-28]
	mov	dword ptr [eax+ecx], esi

	movsx eax, word ptr [ebp-12]
	shl	eax, 4						; присвоение временной переменной 
	lea	edi, dword ptr [ebp-8]		; значения вещественного представления особи
	mov	ecx, dword ptr [ebp-28]
	lea	esi, dword ptr [ecx+eax+8]
	mov	ecx, 8
	rep	movsb

	movsx eax, word ptr [ebp-12]
	mov	esi, eax
	shl	esi, 4
	movsx eax, dx
	mov	ecx, eax					; обмен вещественными значениями
	shl	ecx, 4
	mov	eax, dword ptr [ebp-28]
	lea	edi, dword ptr [eax+esi+8]
	mov	eax, dword ptr [ebp-28]
	lea	esi, dword ptr [eax+ecx+8]
	mov	ecx, 8
	rep	movsb

	movsx eax, dx
	shl	eax, 4
	mov	ecx, dword ptr [ebp-28]
	lea	edi, dword ptr [ecx+eax+8]
	lea	esi, dword ptr [ebp-8]
	mov	ecx, 8
	rep	movsb
Swap:
	cmp	bx, dx
	jg Swap_Check	
Check:
	mov	ax, word ptr [ebp-20]
	cmp	ax, word ptr [ebp-12]
	jg	Internal_Cycle
Epilogue:
	pop	edi
	pop	esi
	pop	ebx
	leave ; чистим стек и выходим
	ret	12
sort endp

End