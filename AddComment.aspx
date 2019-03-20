<%@ Page Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="AddComment.aspx.cs" Inherits="AddComment"
    Title="Add Comments Page" MaintainScrollPositionOnPostback="true" 
    ValidateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        #txtWebsite
        {
            width: 150px;
        }
        #txtEmail
        {
            width: 150px;
        }
        #txtName
        {
            width: 150px;
        }
        .style1
        {
            color: #FF3300;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ListView ID="lvComment" runat="server"
        onitemediting="lvComment_ItemEditing"
        onitemupdating="lvComment_ItemUpdating"
        onitemcanceling="lvComment_ItemCanceling"
        onitemdeleting="lvComment_ItemDeleting" 
        oniteminserting="lvComment_ItemInserting">
    
    <LayoutTemplate> 
    	  <p id="addcomment"><b>Add comment</b></p>

        <asp:PlaceHolder ID="itemPlaceholder" runat="server" /> 
    </LayoutTemplate>
<ItemTemplate>

    <asp:Button ID="DeleteButton" CssClass="button" runat="server" CommandName="Delete" Text="Delete" />
    <asp:Button ID="EditButton" CssClass="button" runat="server" CommandName="Edit" Text="Edit" />
    <asp:LinkButton ID="Button1" runat="server" PostBackUrl="~/ListComments.aspx" CssClass="button" Text="List Comment" />

    <div class="comment">
	 <label for="txtName">Name:</label>
	 <asp:TextBox ReadOnly="true" ID="txtName" runat="server" Text='<%# Bind("Name") %>' />
       
<br />

	  <label for="txtEmail">Email:</label>
	  <asp:TextBox ReadOnly="true" ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' />
 
<br />
	  <label for="txtWebsite">Website:</label>
       <asp:TextBox ReadOnly="true" ID="txtWebsite" runat="server" Text='<%# Bind("Website") %>' />
<br />

<label for="txtContent">Comment:</label>
	  <div id="commentCompose" class="content">
          <asp:TextBox ReadOnly="true" Columns="60" Rows="5" ID="txtContent" runat="server" Text='<%# Bind("Comment") %>' TextMode="MultiLine" />
	  </div>
	<asp:Label ID="cmntID" style="visibility:hidden;" runat="server" Text='<%# Bind("ID") %>' />
  
    </div>
 
</ItemTemplate>

<EditItemTemplate>
    <asp:Button ID="btnUpdateInline" CssClass="button" runat="server" CommandName="Update" CommandArgument="InlineQuery" Text="Update using inline query" />
    <asp:Button ID="btnUpdateSPDQ" CssClass="button" runat="server" CommandName="Update" Text="Update using SP - Dynamic Query" CommandArgument="SP_DynamicQuery" />
     <asp:Button ID="btnUpdateSP" CssClass="button" runat="server" CommandName="Update" Text="Update using SP" CommandArgument="SP" />
    <asp:Button ID="CancelButton" CssClass="button" runat="server" CommandName="Cancel" Text="Cancel" />

<div class="comment">

	 <label for="txtName">Name:</label>
	 <%--<asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' />--%>
	 <input id="txtName" runat="server" value='<%# Bind("Name") %>' />
	  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="*" Display="Dynamic" ControlToValidate="txtName" />
<br />

	  <label for="txtEmail">Email:</label>
	  <asp:TextBox ID="txtEmail" ReadOnly="true" runat="server" Text='<%# Bind("Email") %>' />

<br />
	  <label for="txtWebsite">Website:</label>
       <asp:TextBox ID="txtWebsite" runat="server" Text='<%# Bind("Website") %>' />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ErrorMessage="*" Display="Dynamic" ControlToValidate="txtWebsite" />
<br />

<label for="txtContent">Comment:</label>
	  <div id="commentCompose" class="content">
          <asp:TextBox Columns="60" Rows="5" ID="txtContent" runat="server" Text='<%# Bind("Comment") %>' TextMode="MultiLine" />
           <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ErrorMessage="*" Display="Dynamic" ControlToValidate="txtContent" />
	  </div>

    <asp:Label ID="cmntID" style="visibility:hidden;" runat="server" Text='<%# Bind("ID") %>' />
    </div>
 
</EditItemTemplate>

<InsertItemTemplate>
    <asp:Button ID="InsertButton" runat="server" CssClass="button" CommandName="Insert" Text="Insert" OnClientClick="return validate();" />
    <asp:Button ID="CancelButton" runat="server" CssClass="button" CommandName="Cancel" Text="Clear" />
    <asp:LinkButton ID="Button1" runat="server" PostBackUrl="~/ListComments.aspx" CssClass="button" Text="List Comment" />

    <div class="comment">
	 <label for="txtName">Name:</label>
	 <asp:TextBox ID="txtName" runat="server" Text="" />

<br />

	  <label for="txtEmail">Email:</label>
	  <asp:TextBox ID="txtEmail" runat="server" Text="" />
 
<br />
	  <label for="txtWebsite">Website:</label>
       <asp:TextBox ID="txtWebsite" runat="server" Text="" />
<br />

<label for="txtContent">Comment:</label>
	  <div id="commentCompose" class="content">
          <asp:TextBox Columns="60" Rows="5" ID="txtContent" runat="server" Text="" TextMode="MultiLine" />
	  </div>
	  
	  <br />

    </div>
</InsertItemTemplate>
    </asp:ListView>
    

<div runat="server" id="divSuccess" 
    style='position:absolute;z-index:5;top:45%;left:45%; width:100px; height:50px; 
        background-color:White; border: solid 1px red; padding: 25px; display:none;'>
     <asp:Label ID="lblMsg" runat="server" Text="Success"></asp:Label>
</div>

<script type="text/javascript">
    function validate() {
        if (document.getElementById("ctl00_ContentPlaceHolder1_lvComment_ctrl0_txtName").value === "") {
            alert("Name required!");
            return false;
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_lvComment_ctrl0_txtEmail").value === "") {
            alert("Email required!");
            return false;
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_lvComment_ctrl0_txtWebsite").value === "") {
            alert("Website required!");
            return false;
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_lvComment_ctrl0_txtContent").value === "") {
            alert("Comment required!");
            return false;
        }
    }
</script>

</asp:Content>

