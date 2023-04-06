unit BitOperations; 

interface

uses Entity, ConfigParser;

procedure InverseBit(var entity: EntityT; index: integer); // инверсия бита по индексу
procedure SetBit(var entity: EntityT; bit: integer; index: integer); // установить бит по индексу
function GetBit(var entity: EntityT; index: integer): integer; // получить бит по индексу

implementation

// инверсия бита по индексу
procedure InverseBit(var entity: EntityT; index: integer);
	begin
	entity.bits := entity.bits xor (1 shl index);
	end;

// получить бит по индексу
function GetBit(var entity: EntityT; index:integer): integer;
	begin
	GetBit := (entity.bits shr index) and 1;
	end;

// установить бит по индексу
procedure SetBit(var entity: EntityT; bit: integer; index: integer); 
	begin
	if bit = 0 then 
		entity.bits := entity.bits and not (1 shl index) 
	else
		entity.bits := entity.bits or (1 shl index); 
	end;

end.
