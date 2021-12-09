library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity dingshi is 
	port (
	fclk : in std_logic;    --输入经过分频之后的时钟信号   暂且为十分频信号            
	xinhao:in std_logic;
	tim:in integer;
	key_dingshi:in std_logic;
	flag_down: out std_logic:='1';
	btim: out std_logic_vector(3 downto 0); --百位输出定时的时间   以半小时为单位最多3小时
	stim: out std_logic_vector(3 downto 0); --十位输出定时的时间   以半小时为单位最多3小时
	gtim: out std_logic_vector(3 downto 0) --个位输出定时的时间   以半小时为单位最多3小时
	);	
end dingshi;
architecture behav of dingshi is
signal stim1:INTEGER:=0;
signal flag:std_logic:='1';
signal flag1:std_logic:='0';
signal sflag_down:std_logic:='1';
signal tim1:INTEGER RANGE 0 TO 9;
signal tim2:INTEGER RANGE 0 TO 9;
signal tim3:INTEGER RANGE 0 TO 9;
begin
process(xinhao,fclk)
begin
if xinhao='1'then
	if fclk'event and fclk='1'then
		if flag='1'then
			stim1<=tim;
			flag<=flag1'delayed(10ns);
		end if;
		if stim1=0 then
			sflag_down<= not sflag_down;
			if sflag_down='0'then
				flag_down<='0';
			end if;
		else
			stim1<=stim1-1;
		end if;
	end if;
	tim1<=stim1/100;
	tim2<=(stim1 rem 100)/10;
	tim3<=stim1-100*tim1-10*tim2;
	btim <= CONV_STD_LOGIC_VECTOR(tim1, 4);---将tem十位数转换成二进制数输出
   stim <= CONV_STD_LOGIC_VECTOR(tim2, 4); ---将tem个位数转换成二进制数输出
   gtim <= CONV_STD_LOGIC_VECTOR(tim3, 4); ---将tem个位数转换成二进制数输出
end if;
if xinhao='0'then
btim<="0000";
stim<="0000";
gtim<="0000";
end if;
	if key_dingshi='0'then
	flag_down<='1';
	end if;
end process;                                 
end behav;