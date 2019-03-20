using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

public partial class AddComment : System.Web.UI.Page
{
    private string _strTSQL = string.Empty;
    private string _strID = string.Empty;

    public string StrID
    {
        set
        {
            ViewState["StrID"] = value;
        }
        get
        {
            if (ViewState["StrID"] == null)
            {
                return "0";
            }
            else
            {
                return ViewState["StrID"] as string;
            }
        }
    }

    public string StrSQl
    {
        get
        {
          //  int intID = 0;
          //  int.TryParse(StrID, out intID);

            string strTsql = string.Empty;
            strTsql = "SELECT * FROM dbo.MyComments WHERE ID = " + StrID + " ORDER BY ID";
            return strTsql;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lvComment.ItemCommand += new EventHandler<ListViewCommandEventArgs>(lvComment_ItemCommand);
        if (!IsPostBack)
        {
            string qstrMode = Request.QueryString["mode"] as string;
            if (!string.IsNullOrEmpty(qstrMode))
            {
                switch (qstrMode.ToLower())
                {
                    case "add":
                        StrID = "0";
                        InsertUserScreen();

                        break;
                    case "edit":
                        StrID = Request.QueryString["id"] as string;
                        InsertUserScreen();
                        break;
                    default:
                        BindListView("");
                        break;
                }
            }
            else
            {
                BindListView("");
            }
        }
        NoCache();
    }

    void lvComment_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Insert":
                {
                   // InsertComment(e.Item);
                    break;
                }
            case "Update":
                {
                    UpdateComment(e.CommandArgument as string, e.Item);
                    break;
                }
            case "Delete":
                {
                  //  DeleteComment(e.CommandArgument as string);
                    break;
                }
        }

    }

    void NoCache()
    {
        Response.AddHeader("Cache-Control", "no-cache");
        Response.Expires = -1;
        Response.Cache.SetNoStore();
        Response.AddHeader("Pragma", "no-cache");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }

    void InsertUserScreen()
    {
        int intID = 0;
        int.TryParse(StrID, out intID);

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();

        if (intID == 0)
        {
            lvComment.InsertItemPosition = InsertItemPosition.FirstItem;
        }
        else
        {
            lvComment.InsertItemPosition = InsertItemPosition.None;
        }

        BindListView(StrSQl);

    }

    void BindListView(string strQ)
    {
        if (string.IsNullOrEmpty(strQ))
        {
            strQ = "SELECT * FROM dbo.MyComments ORDER BY [ID]";
        }

        DbCommand dbCommand = Utilities.GetDatabase().GetSqlStringCommand(strQ);
        DataSet dsComments = Utilities.GetDatabase().ExecuteDataSet(dbCommand);

        lvComment.DataSource = dsComments;
        lvComment.DataBind();
    }

    void UpdateComment(string updateMethod, ListViewItem editItem)
    {
        string strID = string.Empty, strName = string.Empty, strWeb = string.Empty, strComment = string.Empty;
        Label lblID = (editItem.FindControl("cmntID")) as Label;
        
        string strScript = string.Empty;
        int intResult = -1;

        if (lblID != null) strID = lblID.Text;

        HtmlInputText txtName = (editItem.FindControl("txtName")) as HtmlInputText;

        if (txtName != null) strName = txtName.Value;

        TextBox txtWebsite = (editItem.FindControl("txtWebsite")) as TextBox;

        if (txtWebsite != null) strWeb = txtWebsite.Text;

        TextBox txtContent = (editItem.FindControl("txtContent")) as TextBox;

        if (txtContent != null) strComment = txtContent.Text;

        string errMsg = string.Empty;

        Database db = Utilities.GetDatabase();

        if (updateMethod.Equals("InlineQuery"))
        {
            StringBuilder sbTSQL = new StringBuilder(string.Empty);
            
            sbTSQL.Append("UPDATE dbo.MyComments SET ");
            sbTSQL.Append(" Name = '" + strName.Replace("'", "''") + "', ");
            sbTSQL.Append(" Website = '" + strWeb + "', ");
            sbTSQL.Append(" Comment = '" + strComment + "' ");
            sbTSQL.Append(" WHERE ID = " + strID);
            // sbTSQL.Append(" WHERE ID = " + strID.Replace("'","''"));

            using (DbCommand dbCommand = db.GetSqlStringCommand(sbTSQL.ToString()))
            {
                intResult = db.ExecuteNonQuery(dbCommand);
            }
        }
        else
        {
            using (DbCommand dbCommand = db.GetStoredProcCommand("UpdateComment"))
            {
                if (updateMethod.Equals("SP_DynamicQuery"))
                {
                    db.AddInParameter(dbCommand, "UpdateMethod", DbType.String, "dynamic");
                }
                else
                {
                    db.AddInParameter(dbCommand, "UpdateMethod", DbType.String, "");
                }

                db.AddInParameter(dbCommand, "Name", DbType.String, strName);
                db.AddInParameter(dbCommand, "Website", DbType.String, strWeb);
                db.AddInParameter(dbCommand, "Comment", DbType.String, strComment);
                db.AddInParameter(dbCommand, "ID", DbType.Int32, strID);

                intResult = db.ExecuteNonQuery(dbCommand);
            }
        }

        if (intResult != -1)
        {
            ShowMessageBox();
        }

        lvComment.EditIndex = -1;
        BindListView(StrSQl);
    }

    protected void lvComment_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {      
    }

    protected void lvComment_ItemEditing(object sender, ListViewEditEventArgs e)
    {
        lvComment.EditIndex = e.NewEditIndex;
        BindListView(StrSQl);
    }

    protected void lvComment_ItemCanceling(object sender, ListViewCancelEventArgs e)
    {
        lvComment.EditIndex = -1;
        BindListView(StrSQl);
    }

    protected void lvComment_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
    }

    protected void lvComment_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        string strID = string.Empty, strName = string.Empty, strWeb = string.Empty, strComment = string.Empty;
        string strEmail = string.Empty;
        int intResult = -1;

        string strCtrl = divSuccess.ClientID;
        string strScript = string.Empty;

        TextBox txtName = e.Item.FindControl("txtName") as TextBox;

        if (txtName != null) strName = txtName.Text;

        TextBox txtWebsite = e.Item.FindControl("txtWebsite") as TextBox;

        if (txtWebsite != null) strWeb = txtWebsite.Text;

        TextBox txtContent = e.Item.FindControl("txtContent") as TextBox;

        if (txtContent != null) strComment = txtContent.Text;

        TextBox txtEmail = e.Item.FindControl("txtEmail") as TextBox;

        if (txtEmail != null) strEmail = txtEmail.Text;

        string errMsg = string.Empty;
        StringBuilder sbTSQL = new StringBuilder(string.Empty);

        sbTSQL.Append("INSERT INTO dbo.MyComments ([Name], [Email], [Website], [Comment], [LastUpdate]) Values(");
        sbTSQL.Append(" '" + strName + "', ");
        sbTSQL.Append(" '" + strEmail + "', ");
        sbTSQL.Append(" '" + strWeb + "', ");
        sbTSQL.Append(" '" + strWeb + "', ");
        sbTSQL.Append(" getdate() )");

        Database db = Utilities.GetDatabase();

        using (DbCommand dbCommand = db.GetSqlStringCommand(sbTSQL.ToString()))
        {
            intResult = db.ExecuteNonQuery(dbCommand);
        }

        if (intResult != -1)
        {
            ShowMessageBox();
            ClearTextBoxes(Page);
        }
        lvComment.EditIndex = -1;
    }

    void ShowMessageBox()
    {
        string strScript = string.Empty;
        string strCtrl = divSuccess.ClientID;
        strScript = "<script>HideCtrl('" + strCtrl + "', '3000')</script>"; //hide after 3 sec
        Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), strScript, false);
    }

    public void ClearTextBoxes(Control page)
    {
        foreach (Control c in page.Controls)
        {
            if ((c.GetType() == typeof(TextBox)))
            {
                ((TextBox)(c)).Text = "";
            }
           
            if (c.HasControls())
            {
                ClearTextBoxes(c);
            }
        }
    }

}
