-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- For arithmetic operations on STD_LOGIC_VECTOR
use IEEE.STD_LOGIC_ARITH.ALL;

entity singleportram is
    Port (
        clk     : in  STD_LOGIC;                     -- Clock input
        wr_en   : in  STD_LOGIC;                     -- Write enable
        rd_en   : in  STD_LOGIC;                     -- Read enable
        data    : inout  STD_LOGIC_VECTOR(7 downto 0); -- Data input/output
        addr    : in  STD_LOGIC_VECTOR(3 downto 0)    -- Address input
    );
end singleportram;

architecture Behavioral of singleportram is
    signal temp_data : STD_LOGIC_VECTOR(7 downto 0);
    type Memory_Type is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal Mem : Memory_Type; -- Memory declaration
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if wr_en = '1' and rd_en = '0' then
                Mem(to_integer(unsigned(addr))) <= data; -- Write operation
            elsif rd_en = '1' and wr_en = '0' then
                temp_data <= Mem(to_integer(unsigned(addr))); -- Read operation
            end if;
        end if;
    end process;

    -- Drive data output based on read and write enable signals
    data <= temp_data when (rd_en = '1' and wr_en = '0') else (others => 'Z');

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity singleportram_tb is
end singleportram_tb;

architecture Behavioral of singleportram_tb is
    signal data_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal addr_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal wr_en_tb : STD_LOGIC;
    signal rd_en_tb : STD_LOGIC;
    signal clk_tb : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component singleportram
        Port (
            clk     : in  STD_LOGIC;
            wr_en   : in  STD_LOGIC;
            rd_en   : in  STD_LOGIC;
            data    : inout  STD_LOGIC_VECTOR(7 downto 0);
            addr    : in  STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: singleportram port map(clk => clk_tb, wr_en => wr_en_tb, rd_en => rd_en_tb, data => data_tb, addr => addr_tb);

    -- Clock generation
    clk_process: process
    begin
        clk_tb <= '1';
        wait for 5 ns;
        clk_tb <= '0';
        wait for 5 ns;
    end process;

    -- Test process
    process
    variable i : integer;
    variable j : integer;
    begin
        -- Initialize Inputs
        wr_en_tb <= '0';
        rd_en_tb <= '0';
        addr_tb <= (others => '0');

        -- Write operation
        for i in 0 to 15 loop
            wr_en_tb <= '1';
            rd_en_tb <= '0';
            addr_tb <= std_logic_vector(to_unsigned(i, 4));
            data_tb <= std_logic_vector(to_unsigned(i, 8)); -- Write data equal to address
            wait for 10 ns;
        end loop;

        wait for 10 ns;

        -- Read operation
        for j in 0 to 15 loop
            wr_en_tb <= '0';
            rd_en_tb <= '1';
            addr_tb <= std_logic_vector(to_unsigned(j, 4));
            wait for 10 ns;
            report "Data at address " & integer'image(j) & " is " & integer'image(to_integer(unsigned(data_tb)));
        end loop;

        wait; -- Wait indefinitely
    end process;

end Behavioral;