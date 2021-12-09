library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity fengsu is 
	port (
	xinhao: in std_logic;   --接收到的开关信号
	key_fengsu: in std_logic;   --模式按钮
	key_jieneng:in std_logic;
	ruo: out std_logic;
	wei: out std_logic;
	zhong: out std_logic;
	qiang: out std_logic
	);
end fengsu ;
architecture behav of fengsu is
	signal cnnt: integer RANGE 0 TO 3;
begin 
process(xinhao,key_fengsu,key_jieneng)
begin
	if xinhao='1' then
		if key_fengsu'event and key_fengsu='1' then
			if cnnt=3 then
				cnnt<=0;
			else 
				cnnt<=cnnt+1;
			end if;
		end if;
		case cnnt is
		WHEN 0 => ruo<='1';
					 wei<='0';
					 zhong<='0';
					 qiang<='0';		
		WHEN 1 => ruo<='0';
					 wei<='1';
					 zhong<='0';
					 qiang<='0';	
		WHEN 2 => ruo<='0';
					 wei<='0';
					 zhong<='1';
					 qiang<='0';	
		WHEN 3 => ruo<='0';
					 wei<='0';
					 zhong<='0';
					 qiang<='1';
		end case;
		if key_jieneng='1' then
		cnnt<=1;
		end if;
	end if;
	if xinhao='0'then
		ruo<='0';
		wei<='0';
		zhong<='0';
		qiang<='0';
	end if;
end process;                                 
end behav;
