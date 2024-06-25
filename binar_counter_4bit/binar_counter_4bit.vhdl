-- Design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin is
    Port ( rst   : in  STD_LOGIC;                   -- Reset signal
           clk   : in  STD_LOGIC;                   -- Clock signal
           count : out STD_LOGIC_VECTOR (3 downto 0)  -- 4-bit count output
         );
end bin;

architecture Behavioral of bin is
begin

process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            count <= (others => '0');  -- Reset count to 0
        else
            count <= count + 1;        -- Increment count
            if count = "1111" then
                count <= "0000";       -- Reset count if it reaches 15
            end if;
        end if;
    end if;
end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal rst   : STD_LOGIC := '1';                   -- Reset signal
    signal clk   : STD_LOGIC := '0';                   -- Clock signal
    signal count : STD_LOGIC_VECTOR (3 downto 0);      -- 4-bit count signal

    -- Component declaration for the bin module
    component bin
        Port ( rst   : in  STD_LOGIC;
               clk   : in  STD_LOGIC;
               count : out STD_LOGIC_VECTOR (3 downto 0)
             );
    end component;

begin

    -- Instantiate the bin module
    uut: bin port map (rst => rst, clk => clk, count => count);

    -- Clock generation process
    clk_process :process
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process;

    -- Stimulus process to generate reset and end simulation
    stim_proc: process
    begin
        -- Display header for better readability of simulation results
        wait for 5 ns;
        rst <= '0'; -- Deassert reset after 5 ns
        wait for 30 ns;
        wait;
    end process;

    -- Monitoring process to display count value
    monitor : process
    begin
        wait for 1 ns;
        loop
            wait for 2 ns;
            report "Time = " & integer'image(now) & "  rst = " & std_logic'image(rst) & "  count = " & std_logic_vector'image(count);
        end loop;
    end process;

end Behavioral;



