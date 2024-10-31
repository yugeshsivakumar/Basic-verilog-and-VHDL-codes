-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparater_n_bit is
    Port (
        a : in  STD_LOGIC_VECTOR(31 downto 0); -- 32-bit input a
        b : in  STD_LOGIC_VECTOR(31 downto 0); -- 32-bit input b
        l : out STD_LOGIC;                     -- Less than output
        e : out STD_LOGIC;                     -- Equal output
        h : out STD_LOGIC                      -- Greater than output
    );
end Comparater_n_bit;

architecture Behavioral of Comparater_n_bit is
begin

    process(a, b)
    begin
        if (a > b) then
            l <= '0';
            e <= '0';
            h <= '1';
        elsif (a < b) then
            l <= '1';
            e <= '0';
            h <= '0';
        else
            l <= '0';
            e <= '1';
            h <= '0';
        end if;
    end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparater_n_bit_tb is
end Comparater_n_bit_tb;

architecture Behavioral of Comparater_n_bit_tb is
    signal a : STD_LOGIC_VECTOR(31 downto 0);
    signal b : STD_LOGIC_VECTOR(31 downto 0);
    signal l : STD_LOGIC;
    signal e : STD_LOGIC;
    signal h : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component Comparater_n_bit
        Port (
            a : in  STD_LOGIC_VECTOR(31 downto 0);
            b : in  STD_LOGIC_VECTOR(31 downto 0);
            l : out STD_LOGIC;
            e : out STD_LOGIC;
            h : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    uut: Comparater_n_bit port map(a => a, b => b, l => l, e => e, h => h);

    -- Stimulus process
    process
    begin
        a <= "00000000000000000000000000010110";  -- a = 22
        b <= "00000000000000000000000011001000";  -- b = 200
        wait for 10 ns;

        a <= "00000000111010001";                  -- a = 233
        b <= "00000000000000000000000011001000";  -- b = 200
        wait for 10 ns;

        a <= "00000001101110000";                  -- a = 888
        b <= "00000001101110000";                  -- b = 888
        wait for 10 ns;

        a <= "0000000001111011";                   -- a = 123
        b <= "00000000011101000";                  -- b = 234
        wait for 10 ns;

        wait;  -- Wait indefinitely
    end process;

    -- Monitor process
    process
    begin
        wait for 10 ns; -- Wait for the first change
        while true loop
            report "A=" & std_logic_vector(a) & " B=" & std_logic_vector(b) & " L=" & std_logic'image(l) & " E=" & std_logic'image(e) & " H=" & std_logic'image(h);
            wait for 10 ns;
        end loop;
    end process;

end Behavioral;

