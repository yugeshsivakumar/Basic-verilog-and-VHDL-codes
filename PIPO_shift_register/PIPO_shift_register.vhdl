-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipo is
    Port (
        din : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        dout : out std_logic_vector(3 downto 0)
    );
end pipo;

architecture Behavioral of pipo is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                dout <= "0000";
            else
                dout <= din;
                report "Time=" & integer'image(time) &
                       " rst=" & std_logic'image(rst) &
                       " din=" & std_logic_vector'image(din) &
                       " dout=" & std_logic_vector'image(dout);
            end if;
        end if;
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal clk, rst : std_logic := '0';
    signal din : std_logic_vector(3 downto 0);
    signal dout : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin
    -- Clock generation process
    clk_gen_proc: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Reset process
    rst_proc: process
    begin
        rst <= '1';
        wait for 5 ns;
        rst <= '0';
        wait for CLK_PERIOD * 50;
        report "Simulation finished";
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        wait for CLK_PERIOD * 10;
        for i in 0 to 39 loop
            din <= std_logic_vector(to_unsigned(integer(unsigned(din)) + 1, din'length));
            wait for CLK_PERIOD;
        end loop;
        wait;
    end process;

    -- Instance of pipo module
    pipo_inst: entity work.pipo
        port map (
            din => din,
            clk => clk,
            rst => rst,
            dout => dout
        );

    -- Monitor process
    monitor_proc: process (clk, rst, din, dout)
    begin
        wait until rising_edge(clk);
        report "Time=" & integer'image(time) &
               " rst=" & std_logic'image(rst) &
               " din=" & std_logic_vector'image(din) &
               " dout=" & std_logic_vector'image(dout);
        wait;
    end process;

end Behavioral;
