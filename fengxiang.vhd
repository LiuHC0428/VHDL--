library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity fengxiang is 
	port (
	clk:in std_logic;
	xinhao: in std_logic;   --接收到的开关信号
	key_fengxiang: in std_logic_vector(1 downto 0);   --模式按钮
	key_jieneng:in std_logic;
	sx: out std_logic;--上下扫风
	zy: out std_logic--左右扫风
	);
end fengxiang;
architecture behav of fengxiang is
	component maichong
		port (
			clk:in std_logic;				--高频脉冲信号
			key_in:in std_logic;		--输入的需要捕获下降沿的信号
			key_out:out std_logic	--输出信号
		);
	end component maichong;
	signal ssx:integer RANGE 0 TO 1:=0;
	signal szy:integer RANGE 0 TO 1:=0;
	signal key_fengxiang1:std_logic;
	signal sx1:std_logic;
	signal zy1:std_logic;
	signal sx2:std_logic;
	signal zy2:std_logic;
begin 
sx1<=key_fengxiang(1);
zy1<=key_fengxiang(0);
MC: maichong port map(clk,sx1,sx2);
MC1: maichong port map(clk,zy1,zy2);
process(xinhao,clk,sx2,zy2)
begin
if clk'event and clk='1' then
	if xinhao='1' then
		if sx2='1' then
			if ssx=1 then
				ssx<=0;
				sx<='0';
			else
				ssx<=ssx+1;
				sx<='1';
			end if;
		end if;
		if zy2='1' then
			if szy=1 then
				szy<=0;
				zy<='0';
			else
				szy<=szy+1;
				zy<='1';
			end if;
		end if;
		if key_jieneng='1' then
			sx<='0';
			zy<='0';
		end if;
	end if;
end if;
	if xinhao='0'then
	sx<='0';
	zy<='0';
	ssx<=0;
	szy<=0;
	end if;
end process;                                 
end behav;
