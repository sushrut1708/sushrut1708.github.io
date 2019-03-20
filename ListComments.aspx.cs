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
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

public partial class ListComments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strQs, strSQL = string.Empty;
        strSQL = "SELECT * FROM dbo.[MyComments] ORDER BY ID";

        if (Request.QueryString["cid"] != null)
        {
            strQs = Request.QueryString["cid"] as string;
            strSQL = "SELECT * FROM dbo.[MyComments] WHERE [id]=" + strQs + " ORDER BY [Name]";
        }
        if (Request.QueryString["show"] != null)
        {
            Response.Write(strSQL);
        }

        GetComments(strSQL);
    }

    void GetComments(string strTsql)
    {
        string sqlCommand = string.Empty;
        string strResult = string.Empty;
        DataSet dsComments = new DataSet();

        Database db = Utilities.GetDatabase();
        using (DbCommand dbCommand = db.GetSqlStringCommand(strTsql))
        {
            dsComments = db.ExecuteDataSet(dbCommand);
        }

         if (dsComments != null)
        {
            dlComments.DataSource = dsComments;
            dlComments.DataBind();
        }
    }
}
