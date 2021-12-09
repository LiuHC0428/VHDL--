library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity jieneng is 
	port (
	xinhao: in std_logic;   --接收到的开关信号
	key_jieneng1: in std_logic;   --模式按钮
	key_jieneng: out std_logic   --模式按钮
	);
end jieneng ;
architecture behav of jieneng is
begin 
process(xinhao,key_jieneng1)
variable cnnt: integer:=0;
begin
	if xinhao='1'then
		if key_jieneng1'event and key_jieneng1='1'then
			if cnnt=1 then
				cnnt:=0;
				key_jieneng<='0';
			else
				cnnt:=cnnt+1;
				key_jieneng<='1';
			end if;
		end if;
	end if;
end process;                                 
end behav;
