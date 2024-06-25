
-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_ff is
    Port ( 
        j : in  std_logic;
        k : in  std_logic;
        rst : in  std_logic;
        clk : in  std_logic;
        q : out  std_logic;
        qb : out  std_logic
    );
end jk_ff;

architecture Behavioral of jk_ff is
begin
    process (clk, rst)
    begin
        if rst = '0' then
            q <= '0';  -- Reset condition
            qb <= '1';  -- Inverted output
        elsif rising_edge(clk) then
            case (j & k) is
                when "00" =>
                    q <= q;
                when "01" =>
                    q <= '0';
                when "10" =>
                    q <= '1';
                when "11" =>
                    q <= not q;
                when others =>
                    q <= q;
            end case;
            qb <= not q;  -- Output qb is the complement of q
        end if;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal j, k, rst, clk : std_logic;
    signal q, qb : std_logic;
    constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin
    -- Clock generation process
    clk_proc: process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        rst <= '1';
        j <= '0';
        k <= '0';
        wait for CLK_PERIOD;
        
        rst <= '0';
        wait for CLK_PERIOD * 5;
        
        for i in 0 to 3 loop
            j <= std_logic(to_unsigned(i, j'length));
            k <= std_logic(to_unsigned(i, k'length));
            wait for CLK_PERIOD;
        end loop;
        
        for i in 3 downto 0 loop
            j <= std_logic(to_unsigned(i, j'length));
            k <= std_logic(to_unsigned(i, k'length));
            wait for CLK_PERIOD;
        end loop;
        
        wait;
    end process;

    -- Instance of jk_ff module
    jk_ff_inst: entity work.jk_ff
        port map (
            j => j,
            k => k,
            rst => rst,
            clk => clk,
            q => q,
            qb => qb
        );

    -- Monitor process
    monitor_proc: process
    begin
        wait for CLK_PERIOD;
        report "Time = " & integer'image(to_integer(unsigned(clock))) &
               " rst = " & std_logic'image(rst) &
               " j = " & std_logic'image(j) &
               " k = " & std_logic'image(k) &
               " q = " & std_logic'image(q) &
               " qb = " & std_logic'image(qb);
        wait;
    end process;

end Behavioral;

