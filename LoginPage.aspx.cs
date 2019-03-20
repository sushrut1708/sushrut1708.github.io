using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strQs = string.Empty;
        if (Request.QueryString["strErr"] != null)
        {
            strQs = Request.QueryString["strErr"] as string;
            lblDisplayErr.Text = strQs;
            HideLabel();
        }
        NoCache(); //remove cache
        ReadFromCookies();
    }

    void ReadFromCookies()
    {
        lblCookies.Text = string.Empty;
        if (Response.Cookies["email"] != null)
        {
            HttpCookie aCookie = Request.Cookies["email"];
            if (!string.IsNullOrEmpty(aCookie.Value))
            {
                lblCookies.Text = "Data from cookies:" + aCookie.Value;
            }
        }
        
    }

    //create cookies
    void FakeCookies()
    {
        Response.Cookies["email"].Value = txtUserName.Text;
        Response.Cookies["email"].Expires = DateTime.Now.AddDays(1);

        Response.Cookies["age"].Value = "22";
        Response.Cookies["age"].Expires = DateTime.Now.AddDays(1);
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string sqlCommand = string.Empty;
        string strResult = string.Empty;
        object oEs;

        sqlCommand = "SELECT 'b' FROM dbo.tbl_users WHERE username='" + txtUserName.Text + "' AND password='"+ txtPassword.Text+ "'";

        Database db = Utilities.GetDatabase();

        using (DbCommand dbCommand = db.GetSqlStringCommand(sqlCommand))
        {
            oEs = db.ExecuteScalar(dbCommand);
        }

        if (oEs != null)
        {
            strResult = oEs as string;
        }

        if (!string.IsNullOrEmpty(strResult))
        {
            lblDisplayErr.Text = "Login successful";
            FakeCookies();
        }
        else
        {
            Response.Redirect("LoginPage.aspx?strErr=Invalid Username or Password");
        }
        HideLabel();

    }

    void NoCache()
    {
        Response.AddHeader("Cache-Control", "no-cache");
        Response.Expires = -1;
        Response.Cache.SetNoStore();
        Response.AddHeader("Pragma", "no-cache");

    }

    void HideLabel()
    {
        string strScript = string.Empty;
        string strCtrl = lblDisplayErr.ClientID;
        strScript = "<script>HideCtrl('" + strCtrl + "', '5000')</script>"; //hide after 3 sec
        Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), strScript, false);
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        Server.Transfer("LoginPage.aspx");
    }

}
