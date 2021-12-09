library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity moshi is 
	port (
	xinhao: in std_logic;   --接收到的开关信号
	key_moshi: in std_logic;   --模式按钮
	cold: out std_logic;
	hot: out std_logic;
	wind: out std_logic;
	dry: out std_logic
	);
end moshi;
architecture behav of moshi is

	signal cnnt: integer RANGE 0 TO 3;
begin 
process(xinhao,key_moshi)
begin
	if xinhao='1' then
		if key_moshi'event and key_moshi='1' then
			if cnnt=3 then
				cnnt<=0;
			else 
				cnnt<=cnnt+1;
			end if;
		end if;
		case cnnt is
		WHEN 0 => cold<='1';
					 hot<='0';
					 wind<='0';
					 dry<='0';		
		WHEN 1 => cold<='0';
					 hot<='1';
					 wind<='0';
					 dry<='0';	
		WHEN 2 => cold<='0';
					 hot<='0';
					 wind<='1';
					 dry<='0';	
		WHEN 3 => cold<='0';
					 hot<='0';
					 wind<='0';
					 dry<='1';
		end case;
	end if;
	if xinhao='0' then
		cold<='0';
		hot<='0';
		wind<='0';
		dry<='0';
	end if;
end process;                                 
end behav;
