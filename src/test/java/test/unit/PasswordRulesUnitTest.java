package test.unit;

import main.PasswordRules;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.MatcherAssert.assertThat;

public class PasswordRulesUnitTest {
    @Test
    public void testPasswordLength1() {
        assertThat(new PasswordRules("a").evaluate(), is("password must be at least 8 characters long"));
    }
    @Test
    public void testPasswordLength7() {
        assertThat(new PasswordRules("abcdefg").evaluate(), is("password must be at least 8 characters long"));
    }
    @Test
    public void testPasswordLength8() {
        assertThat(new PasswordRules("12345678").evaluate(), not("password must be at least 8 characters long"));
    }
    @Test
    public void testPasswordAllNumbers() {
        assertThat(new PasswordRules("12345678").evaluate(), is("password must have letters in it"));
    }
    @Test
    public void testPasswordAllUpperCase() {
        assertThat(new PasswordRules("HOWARDDEINER").evaluate(), is("password must have both upper and lower case letters in it"));
    }
    @Test
    public void testPasswordAllLowerCase() {
        assertThat(new PasswordRules("howarddeiner").evaluate(), is("password must have both upper and lower case letters in it"));
    }
    @Test
    public void testPasswordNoDigits() {
        assertThat(new PasswordRules("HowardDeiner").evaluate(), is("password must have at least 1 digit in it"));
    }
    @Test
    public void testPasswordNoSpecialCaseCharacters() {
        assertThat(new PasswordRules("HowardDeiner1").evaluate(), is("password must have at least 1 special case character in it"));
    }
    @Test
    public void testPasswordWithSpaces() {
        assertThat(new PasswordRules("Howard Deiner!").evaluate(), is("password can not have any spaces in it"));
    }
    @Test
    public void testPasswordOK() {
        assertThat(new PasswordRules("bFihJv!srBChibW4ay#eXEksdh").evaluate(), is("password OK"));
    }
}