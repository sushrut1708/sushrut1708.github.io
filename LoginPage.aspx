<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" 
    AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" ValidateRequest="false" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
    <table border="0" align= "" cellpadding="2" cellspacing="2" 
        style="width: 315px">
    <tr>
        <td colspan = "2"><h4><asp:Label ID="lbl_Default_Login_Page" runat="server" Text="Login Information"></asp:Label>
            </h4></td>
    </tr>
    <tr>
        <td width ="40%">
            <asp:Label ID="Label1" runat="server" Text="Login ID :" CssClass="regularText" 
                AssociatedControlID="txtUserName"></asp:Label></td>
        <td>
            <asp:TextBox ID="txtUserName" runat="server" CssClass="regularText" Width="125px"
                MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtUserName" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        </td>
    </tr>
   
    <tr>
        <td>
            <asp:Label ID="Label2" runat="server" Text="Password :" CssClass="regularText" AssociatedControlID="txtPassword"></asp:Label></td>
        <td>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="125px"
                CssClass="regularText" MaxLength="25"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtPassword" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        </td>
    </tr>
  
    <tr>
        <td align="center" colspan="2">
            <asp:Label ID="lblDisplayErr" runat="server" Text="" CssClass="labelError" />
        </td>
    </tr>
    <tr align="center">
        <td>&nbsp;</td>
        <td align="left">
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="button" OnClick="btnLogin_Click" />&nbsp;
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="button" OnClick="btnClear_Click" CausesValidation="false" />&nbsp;
            
            </td>
    </tr>
    <tr>
        <td colspan="2" align="center">&nbsp;</td>
    </tr>
</table>
<br /><br />
    <asp:Label ID="lblCookies" CssClass="regularText" runat="server" Text=""></asp:Label>
</div>
</asp:Content>

