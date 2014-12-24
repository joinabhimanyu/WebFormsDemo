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
using System.Text;
using System.IO;
using System.Net;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;
using System.Xml;
using System.Xml.Linq;


namespace WebFormsDemo
{
    public class EventDrivenActivity
    {
        public string eventname { get; set; }
        public string handleExternal { get; set; }
        public string setState { get; set; }
    }

    public class StateActivity
    {
        public string state_name { get; set; }

        public List<EventDrivenActivity> event_driven { get; set; }

    }

    public class DisplayState
    {
        public string disp_state_name { get; set; }
        public List<string> target_states { get; set; }
    }

    public partial class WebForm3 : System.Web.UI.Page
    {
        public List<StateActivity> actual_states = null;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                lblHeader.Text = "Welcome to Workflow Modification Wizard";

                if (Request.GetFriendlyUrlSegments().Count > 0)
                {
                    IList<string> segments = Request.GetFriendlyUrlSegments();
                    int param_count = Request.GetFriendlyUrlSegments().Count;
                    for (int i = 0; i < param_count; i++)
                    {
                        lblHeader.Text = "Great";
                        lblHeader.Text += @", Your file path seems to be ' C:\inetpub\wwwroot\Download\ " + segments[i].ToString().Trim() + ".xoml'";
                    }

                }

            }
        }


        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        [WebMethod]
        public static string CheckUser(string value)
        {
            string result = string.Format("Welcome {0}", value);

            return result;

        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        [WebMethod]
        public static string GenerateFile(string workflow_name)
        {
            string result = "";
            try
            {


                result = "success";
            }
            catch (Exception ex)
            {

                result = ex.Message.ToString().Trim();
            }

            return result;
        }

        protected void btnShowResult_Click(object sender, EventArgs e)
        {

            List<StateActivity> states = null;
            StateActivity state = null;
            List<EventDrivenActivity> eves = null;
            EventDrivenActivity ev = null;
            

            //string filePath = @"C:\inetpub\wwwroot\Download\TestWF.xoml";

            //inner_element.Element(w + "HandleExternalEventActivity").Attribute(x + "Name").Value.ToString().Trim() + " with event name " + 
            //inner_element.Element(w + "SetStateActivity").Attribute(x + "Name").Value.ToString().Trim() + " with target state " + 

            string filePath = "";
            string result = "";

            if (Request.GetFriendlyUrlSegments().Count > 0)
            {
                IList<string> segments = Request.GetFriendlyUrlSegments();
                filePath = @"C:\inetpub\wwwroot\Download\" + segments[0].ToString().Trim() + ".xoml";
            }
            else
            {
                filePath = txtWorkflowName.Text.Trim();
            }

            if (filePath != "")
            {
                XDocument doc = XDocument.Load(filePath);
                XNamespace w = "http://schemas.microsoft.com/winfx/2006/xaml/workflow";
                XNamespace x = "http://schemas.microsoft.com/winfx/2006/xaml";
                XNamespace p8 = "clr-namespace:WorkFlowClassLibrary;Assembly=WorkFlowClassLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null";

                states = new List<StateActivity>();
                foreach (XElement element in doc.Root.Elements(w + "StateActivity"))
                {
                    state = new StateActivity();
                    state.state_name = element.Attribute(x + "Name").Value.ToString().Trim();

                    eves = new List<EventDrivenActivity>();
                    foreach (XElement inner_element in element.Elements(w + "EventDrivenActivity"))
                    {
                        ev = new EventDrivenActivity();
                        ev.eventname = inner_element.Attribute(x + "Name").Value.ToString().Trim();
                        ev.handleExternal = inner_element.Element(w + "HandleExternalEventActivity").Attribute("EventName").Value.ToString().Trim();
                        ev.setState = inner_element.Element(w + "SetStateActivity").Attribute("TargetStateName").Value.ToString().Trim();
                        eves.Add(ev);
                        ev = null;
                    }
                    state.event_driven = eves;
                    states.Add(state);
                    eves = null;
                    state = null;

                }

                actual_states = states;
                grdStates.DataSource = null;
                grdStates.DataSource = states;
                grdStates.DataBind();

                result = "success";
                
            }
            else
            {
                result = "error";
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script language='javascript' type='text/javascript'>");
            string str = string.Format(@"ShowResultRow('{0}')", result.ToString().Trim());
            sb.Append(str);
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);

        }

        protected void btnDisplayStateTransition_Click(object sender, EventArgs e)
        {

            string result = "error";
            try
            {
                List<DisplayState> dispState = new List<DisplayState>();
                DisplayState state = null;
                List<string> targetStates = null;
                StateActivity tempstate = null;
                string completed_state = "";

                for (int i = 1; i < actual_states.Count; i++)
                {
                    state = new DisplayState();
                    if (!actual_states[i].state_name.ToString().Contains("COMPLETED"))
                    {
                        state.disp_state_name = actual_states[i].state_name.ToString().Trim();
                        completed_state = actual_states[i].event_driven[0].setState.ToString().Trim();

                        tempstate = (from temp in actual_states where temp.state_name == completed_state select temp).First();
                        targetStates = new List<string>();
                        foreach  (EventDrivenActivity ediv in tempstate.event_driven)
	                    {
                            targetStates.Add(ediv.setState.ToString().Trim());
	                    }
                        state.target_states = targetStates;
                        targetStates = null;
                        tempstate = null;
                        dispState.Add(state);
                        state = null;
                    }
                  

                }
                grdStateTransition.DataSource = null;
                grdStateTransition.DataSource = dispState;
                grdStateTransition.DataBind();

            }
            catch (Exception ex)
            {

                result = ex.Message.ToString().Trim();
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script language='javascript' type='text/javascript'>");
            string str = string.Format(@"DisplayStateTransition('{0}')", result.ToString().Trim());
            sb.Append(str);
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "none", sb.ToString(), false);

        }



    }
}