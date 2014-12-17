using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using DbUtility;
using System.Data;
using System.Workflow.Activities;
using System.Workflow.ComponentModel;
using System.Workflow.Runtime;


namespace WebFormsDemo
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                label1.Text = "you just visited the page.";   
                
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            addResult.Text = "You just made a round trip to server, guess you didn't notice that !";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script language='javascript' type='text/javascript'>");
            sb.Append(@"myfunction();");
            sb.Append(@"</script>");
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "JCall1", sb.ToString(), false);
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);
            
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        [WebMethod]
        public static string CallCode(string value)
        {
            string result = string.Format("Welcome {0}", value);

            return result;
            
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        [WebMethod]
        public static string AddMethod(string num1, string num2)
        {
            double d1 = Convert.ToDouble(num1.ToString().Trim());
            double d2 = Convert.ToDouble(num2.ToString().Trim());
            double result = d1 + d2;
            return result.ToString().Trim();
        }

        protected void btnSelectState_Click(object sender, EventArgs e)
        {
            DataObjectClass obj_dataobject = null;
            List<string> result = new List<string>();
            DataTable dt = new DataTable();
            lstSourceStates.Items.Clear();
            lstDestinationStates.Items.Clear();
            try
            {
                obj_dataobject = new DataObjectClass();

                string qstring = "select Distinct k.txt_state_display_name" +
                                 " from workflow_state_master k" +
                                 " where k.txt_state_display_name is not null" +
                                 " order by k.txt_state_display_name";

                dt = obj_dataobject.getSQLDataTable(qstring);
                if (dt != null || dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        result.Add(dt.Rows[i].ItemArray[0].ToString());
                    }
                }

                lstSourceStates.DataSource = result;
                lstSourceStates.DataBind();

                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script language='javascript' type='text/javascript'>");
                sb.Append(@"showSelection();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);

            }
            catch (Exception)
            {

                result.Add("Error occurred");
            }

        }

        protected void lstSourceStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            int[] ar = lstSourceStates.GetSelectedIndices();
            
            if (ar.Length > 0)
            {
                InsertSelection.Enabled = true;
            }
            else
            {
                InsertSelection.Enabled = false;
            }
        }

        protected void InsertSelection_Click(object sender, EventArgs e)
        {
            lstDestinationStates.DataSource = null;
            List<string> result = new List<string>();
            int[] ar = lstSourceStates.GetSelectedIndices();
            if (ar.Length > 0)
            {
                for (int i = 0; i < ar.Length; i++)
                {
                    result.Add(lstSourceStates.Items[ar[i]].ToString().Trim());
                }
                lstDestinationStates.DataSource = result;
                lstDestinationStates.DataBind();
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script language='javascript' type='text/javascript'>");
                sb.Append(@"selectionError();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);
            }
            
        }

        protected void DeleteSelection_Click(object sender, EventArgs e)
        {
            int[] ar = lstDestinationStates.GetSelectedIndices();
            if (ar.Length > 0)
            {
                List<string> bound = new List<string>();
                for (int i = 0; i < ar.Length; i++)
                {
                    bound.Add(lstDestinationStates.Items[ar[i]].Value.ToString().Trim());
                }
                for (int i = 0; i < bound.Count; i++)
                {
                    lstDestinationStates.Items.Remove(bound[i].ToString().Trim());
                    lstDestinationStates.DataBind();
                }
                UpdatePanel1.Update();
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script language='javascript' type='text/javascript'>");
                sb.Append(@"RemoveError();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);
            }
        }

        public void CreateWorkflow()
        {

            


            
        }

    }
}