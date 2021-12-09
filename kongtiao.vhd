library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity kongtiao is 
	port (
	key: in std_logic;  --输入开关信号
	flag_down:in std_logic;
	xinhao: out std_logic   --传输给其他模块的开关信号
	);
end kongtiao;
architecture behav of kongtiao is
signal xh: std_logic;
begin 
process(key,flag_down)
begin
	if key'EVENT and key='1' then
		xinhao<=not xh;
		xh<=not xh;
	end if;
	if flag_down='0'then     --定时结束全部关闭
		xinhao<='0';
		xh<='0';
	end if;
end process;                                 
end behav;
