--design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seq is
    Port ( clk   : in  STD_LOGIC;
           rst   : in  STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0));
end seq;

architecture Behavioral of seq is
    type state_type is (S1, S2, S3, S4, S5, S6, S7);
    signal state : state_type;
begin

process(clk, rst)
begin
    if rst = '1' then
        state <= S1;
        count <= "0000";
    elsif rising_edge(clk) then
        case state is
            when S1 =>
                count <= "0010";
                state <= S2;
            when S2 =>
                count <= "1001";
                state <= S3;
            when S3 =>
                count <= "0100";
                state <= S4;
            when S4 =>
                count <= "0001";
                state <= S5;
            when S5 =>
                count <= "0110";
                state <= S6;
            when S6 =>
                count <= "0011";
                state <= S7;
            when S7 =>
                count <= "1000";
                state <= S1;
            when others =>
                state <= S1;
        end case;
    end if;
end process;

end Behavioral;

--testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '1';
    signal count : STD_LOGIC_VECTOR (3 downto 0);

    component seq
        Port ( clk   : in  STD_LOGIC;
               rst   : in  STD_LOGIC;
               count : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin

    uut: seq port map (clk => clk, rst => rst, count => count);

    clk_process :process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

    stim_proc: process
    begin
        wait for 5 ns;
        rst <= '0';
        wait for 50 ns;
        wait;
    end process;

    monitor : process
    begin
        wait for 1 ns;
        loop
            wait for 2 ns;
            report "Time = " & integer'image(now) & "  Count = " & std_logic_vector'image(count);
        end loop;
    end process;

end Behavioral;
