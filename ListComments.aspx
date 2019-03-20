<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" 
CodeFile="ListComments.aspx.cs" Inherits="ListComments" ValidateRequest="false" Title="Comments listing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:DataList Width="98%" id="dlComments" runat="server" CellPadding="3" 
        BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" 
        CellSpacing="2" GridLines="Both">
    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
    <ItemStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
    <HeaderTemplate>
     <a style="color:#fff;" title="Add Comment" href="AddComment.aspx?mode=add">Add Comment</a>
    </HeaderTemplate>

    <ItemTemplate>
    
        <div class="comment">
          <p class="date">
            <a href="<%# DataBinder.Eval(Container.DataItem, "Website") %>" 
                  style="font-family: Verdana; font-size: small; float:left;" text-align="left">
                    <%# DataBinder.Eval(Container.DataItem, "Name")%></a>
                            <%# DataBinder.Eval(Container.DataItem,"LastUpdate")%>
                            <a title="Edit" href="AddComment.aspx?mode=edit&id=<%# DataBinder.Eval(Container.DataItem,"ID")%>">Edit</a>
          </p>
          
          <p class="content"><%# DataBinder.Eval(Container.DataItem, "Comment")%></p>

        </div>
    
    </ItemTemplate>

    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />

    <FooterTemplate>
    </FooterTemplate>
</asp:DataList>
<%--
 <div>
    <% 
        System.Data.DataTable dtTest1 = null;
        string errMsg = string.Empty;

        dtTest1 = SqlDataAccess.DAL_DC<System.Data.DataTable>("TEXT", "SELECT * FROM [MyComments]", null, ref errMsg, false);
        Session["test"] = "testsession";
        if (dtTest1.Rows.Count > 0)
        {
            int intCount = dtTest1.Rows.Count;
            for (int i = 0; i < intCount; i++)
            {
        %>
              
<div class="comment">
  <p class="date">
    <a href="<%= dtTest1.Rows[i]["Website"]%>" 
          style="font-family: Verdana; font-size: small; float:left;" text-align="left"><%= dtTest1.Rows[i]["Name"]%></a>
                    <%= dtTest1.Rows[i]["LastUpdate"]%><a href="#id_e25d54b1-2e41-4af4-912c-097fe0db02dd">#</a>
  </p>
  
  <p class="content"><%= dtTest1.Rows[i]["Comment"]%></p>

</div>
        <%  } //loop 
            } //if %>
    </div>--%>

</asp:Content>

