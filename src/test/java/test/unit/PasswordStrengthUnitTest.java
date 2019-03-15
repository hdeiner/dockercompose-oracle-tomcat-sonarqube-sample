package test.unit;

import main.PasswordStrength;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class PasswordStrengthUnitTest {
    @Test
    public void testPasswordLength0() {
        assertThat(new PasswordStrength("").evaluate(), is(-8));
    }
    @Test
    public void testPasswordLength8() {
        assertThat(new PasswordStrength("aBcDeFgH").evaluate(), is(0));
    }
    @Test
    public void testPasswordLength16With8SpecialCharacters() {
        assertThat(new PasswordStrength("a!b@c#d$e%f^g&h*").evaluate(), is(16));
    }
    @Test
    public void testPasswordLength12With8RepeatedUpperLowerViolations() {
        assertThat(new PasswordStrength("HowardDeiner").evaluate(), is(-4));
    }
    @Test
    public void testPasswordSortOfOK() {
        assertThat(new PasswordStrength("passWord1!").evaluate(), is(-1));
    }
    @Test
    public void testPasswordDesirable() {
        assertThat(new PasswordStrength("bFihJv!srBChibW4ay#eXEksdh").evaluate(), is(11));
    }
}