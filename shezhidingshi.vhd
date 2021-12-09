library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity shezhidingshi is 
	port (
	clk : in std_logic;              
	xinhao:in std_logic;
	key_dingshi:in std_logic;
	key_jia: in std_logic;   --温度加按钮
	key_jian:in std_logic;    --温度减按钮
	tim:out integer
	);	
end shezhidingshi;
architecture behav of shezhidingshi is
signal stim:INTEGER RANGE 0 TO 180;    --由于仿真时间限制，用一秒表示一分钟
signal cnnt:bit;
begin
process(xinhao,clk)
begin
if key_dingshi='1'then
	if xinhao='1'then
		if cnnt='1' then
			cnnt<='0';
		else
			cnnt<='1';
		end if;
	end if;
end if;
if clk'event and clk='1'then
	if cnnt='1'then
		if key_jia='1'then
			if stim=180 then
				stim<=180;
			else
				stim<=stim+30;
			end if;
		end if;
		if key_jian='1'then
			if stim=0 then
				stim<=0;
			else
				stim<=stim-30;
			end if;
		end if;
	end if;
end if;
if xinhao='0'then
stim<=0;
end if;
	tim<=stim;
end process;                                 
end behav;