library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity wendu is 
	port (
	clk:in std_logic;
	xinhao: in std_logic;   --接收到的开关信号
	key_jia: in std_logic;   --温度加按钮
	key_jian:in std_logic;    --温度减按钮
	key_jieneng:in std_logic;
	tem1:out std_logic_vector(3 downto 0); --输出十位温度 
	tem2:out std_logic_vector(3 downto 0)  --输出个位温度
	);
end wendu;
architecture behav of wendu is
	component maichong
		port (
			clk:in std_logic;				--高频脉冲信号
			key_in:in std_logic;		--输入的需要捕获下降沿的信号
			key_out:out std_logic	--输出信号
		);
	end component maichong;
	signal tem: integer range 16 to 30:=24;
	signal key_jia1:std_logic;
	signal key_jian1:std_logic;
begin 
MC: maichong port map(clk,key_jia,key_jia1);
MC2: maichong port map(clk,key_jian,key_jian1);
process(xinhao,clk,key_jieneng)
	variable q1,q2 : integer range 0 to 9;
begin
if clk'event and clk='1' then
	if xinhao='1'then
		if key_jia1='1' then
			if tem=30 then
				tem<=30;
			else 
				tem<=tem+1;
			end if;
		end if;
		if key_jian1='1'then
			if tem=16 then
				tem<=16;
			else 
				tem<=tem-1;
			end if;
		end if;	
		if key_jieneng='1' then
			tem<=26;
		end if;
		if xinhao='0'then
			tem<=26;
		end if;
		q1 := tem/10;
      q2 := tem REM 10;
      tem1 <= CONV_STD_LOGIC_VECTOR(q1, 4);---将tem十位数转换成二进制数输出
      tem2 <= CONV_STD_LOGIC_VECTOR(q2, 4); ---将tem个位数转换成二进制数输出
	end if;
end if;


end process;                                 
end behav;
