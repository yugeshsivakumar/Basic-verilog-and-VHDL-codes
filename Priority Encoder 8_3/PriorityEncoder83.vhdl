-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;  -- For arithmetic operations
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- For unsigned operations

entity priorityEncoder83 is
    Port (
        en : in  STD_LOGIC;           -- Enable signal
        in : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input
        out : out STD_LOGIC_VECTOR(2 downto 0)  -- 3-bit output
    );
end priorityEncoder83;

architecture Behavioral of priorityEncoder83 is
begin
    process(en, in)
    begin
        if en = '1' then
            case in is
                when "00000001" => out <= "000"; -- Input 0
                when "0000001Z" => out <= "001"; -- Input 1
                when "000001ZZ" => out <= "010"; -- Input 2
                when "00001ZZZ" => out <= "011"; -- Input 3
                when "0001ZZZZ" => out <= "100"; -- Input 4
                when "001ZZZZZ" => out <= "101"; -- Input 5
                when "01ZZZZZZ" => out <= "110"; -- Input 6
                when "1ZZZZZZZ" => out <= "111"; -- Input 7
                when others => out <= "000";     -- Default case
            end case;
        else
            out <= "000"; -- If enable is not active
        end if;
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PriorityEncoder83_tb is
end PriorityEncoder83_tb;

architecture Behavioral of PriorityEncoder83_tb is
    signal in : STD_LOGIC_VECTOR(7 downto 0);
    signal en : STD_LOGIC;
    signal out : STD_LOGIC_VECTOR(2 downto 0);

    -- Component Declaration for the Unit Under Test (UUT)
    component priorityEncoder83
        Port (
            en : in  STD_LOGIC;
            in : in  STD_LOGIC_VECTOR(7 downto 0);
            out : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: priorityEncoder83 port map(en => en, in => in, out => out);

    -- Stimulus process
    process
    begin
        -- Initialize Inputs
        en <= '0';
        in <= "00000001";
        wait for 10 ns; 
        in <= "0000001X"; -- Test cases
        wait for 10 ns; 
        in <= "000001XX";
        wait for 10 ns; 
        in <= "00001XXX";
        wait for 10 ns; 
        in <= "0001XXXX";
        wait for 10 ns; 
        in <= "001XXXXX";
        wait for 10 ns; 
        in <= "01XXXXXX";
        wait for 10 ns; 
        in <= "1XXXXXXX";
        wait for 10 ns; 
        
        en <= '1'; -- Enable the encoder
        in <= "00000001";
        wait for 10 ns; 
        in <= "0000001Z";
        wait for 10 ns; 
        in <= "000001ZZ";
        wait for 10 ns; 
        in <= "00001ZZZ";
        wait for 10 ns; 
        in <= "0001ZZZZ";
        wait for 10 ns; 
        in <= "001ZZZZZ";
        wait for 10 ns; 
        in <= "01ZZZZZZ";
        wait for 10 ns; 
        in <= "1ZZZZZZZ";
        wait for 10 ns; 
        
        wait; -- Wait indefinitely
    end process;

    -- Monitor process
    process
    begin
        wait for 10 ns; -- Wait for the first change
        while true loop
            report "en=" & std_logic'image(en) & " in=" & std_logic_vector'image(in) & " out=" & std_logic_vector'image(out);
            wait for 10 ns; -- Wait for next change
        end loop;
    end process;

end Behavioral;