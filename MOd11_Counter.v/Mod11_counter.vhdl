-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mod11 is
    Port (
        load         : in  STD_LOGIC_VECTOR(3 downto 0);
        load_enable  : in  STD_LOGIC;
        clk          : in  STD_LOGIC;
        rst          : in  STD_LOGIC;
        out          : out STD_LOGIC_VECTOR(3 downto 0)
    );
end mod11;

architecture Behavioral of mod11 is
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                out <= (others => '0');
            else
                if load_enable = '1' then
                    out <= load;
                elsif out = "1010" then  -- 10 in binary is 1010
                    out <= (others => '0'); -- Reset to 0
                else
                    out <= std_logic_vector(unsigned(out) + 1);
                end if;
            end if;
        end if;
    end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mod11_tb is
end mod11_tb;

architecture Behavioral of mod11_tb is
    signal clk_tb     : STD_LOGIC := '0';
    signal rst_tb     : STD_LOGIC;
    signal load_en_tb : STD_LOGIC;
    signal load_tb    : STD_LOGIC_VECTOR(3 downto 0);
    signal out_tb     : STD_LOGIC_VECTOR(3 downto 0);

    -- Component Declaration for the Unit Under Test (UUT)
    component mod11
        Port (
            load         : in  STD_LOGIC_VECTOR(3 downto 0);
            load_enable  : in  STD_LOGIC;
            clk          : in  STD_LOGIC;
            rst          : in  STD_LOGIC;
            out          : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: mod11 port map(load => load_tb, load_enable => load_en_tb, clk => clk_tb, rst => rst_tb, out => out_tb);

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk_tb <= '1';
            wait for 5 ns;
            clk_tb <= '0';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    process
    begin
        rst_tb <= '1';  -- Assert reset
        wait for 50 ns;
        rst_tb <= '0';  -- Deassert reset
        wait for 50 ns;

        load_en_tb <= '1';  -- Load enable
        load_tb <= "0001";  -- Load value 1
        wait for 10 ns;
        load_en_tb <= '0';  -- Deassert load enable
        wait for 20 ns;

        load_en_tb <= '1';  -- Load enable
        load_tb <= "0000";  -- Load value 0
        wait for 10 ns;
        load_en_tb <= '0';  -- Deassert load enable
        wait for 20 ns;

        load_en_tb <= '1';  -- Load enable
        load_tb <= "0001";  -- Load value 1 again
        wait for 10 ns;
        load_en_tb <= '0';  -- Deassert load enable
        wait for 20 ns;

        wait;  -- Wait indefinitely
    end process;

end Behavioral;
