library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity cnt10 is 
	port (
	clk:in std_logic;
	fclk:out std_logic
	);
end cnt10;
architecture behav of cnt10 is
begin 
process(clk)
variable cnnt: integer RANGE 0 TO 9;
begin
	if clk'event and clk='1'then
		if cnnt=9 then
			cnnt:=0;
			fclk<='0';
		else
			cnnt:=cnnt+1;
			if cnnt=9 then
				fclk<='1';
			end if;
		end if;
	end if;
end process;                                 
end behav;
