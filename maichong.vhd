LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--输入一个信号，输出这个一个脉冲宽度的信号；
--是捕获一个下降沿，输出一个脉冲宽度的低电平
ENTITY maichong IS
	PORT( clk:in std_logic;				--高频脉冲信号
			key_in:in std_logic;		--输入的需要捕获下降沿的信号
			key_out:out std_logic);	--输出信号
END maichong;

ARCHITECTURE behav OF maichong IS
	signal s1,s2:std_logic;			--用于纪录信号的变化
	signal s3:std_logic;
BEGIN 
PROCESS(clk,s1,s2)
	BEGIN
		if clk'event and clk='1' then
		s1<=key_in; 
		s2<=s1;
		end if;
		key_out<=((not s1)and s2);
END PROCESS;
END behav;