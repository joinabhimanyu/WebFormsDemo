<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebFormsDemo.WebForm2" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Script.Services" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.core.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.default.css" />
    <script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="Scripts/alertify.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.velocity.min.js"></script>
    <script type="text/javascript" src="Scripts/velocity.ui.js"></script>
    <style type="text/css">
        body {
            background-color: hsla(225, 4%, 22%, 1);
            background-position: center;
            background-repeat: no-repeat;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .container {
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            position: absolute;
        }

        #page-one {
            z-index: 10;
            display: none;
        }

        #page-two {
            z-index: 9;
            display: block;
        }

        #entry-row, #result-row {
            margin-top: 10px;
        }

        #result-row {
            height: auto;
        }

        #txtBox, #txtNum1, #txtNum2 {
            margin-top: 7px;
        }

        #btnSubmit, #btnAdd {
            margin-top: 6px;
        }

        #label1 {
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 44px;
            -webkit-transition: all 0.3s linear;
            -moz-transition: all 0.3s linear;
            -o-transition: all 0.3s linear;
            transition: all 0.3s linear;
        }

        #addResult {
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 25px;
        }

            #label1:hover, #addResult:hover {
                -o-animation: scale 1.0s ease-in;
                -webkit-animation: scale 1.0s ease-in;
                -moz-animation: scale 1.0s ease-in;
                animation: scale 1.0s ease-in;
            }

        @font-face {
            font-family: myFont;
            src: url('~/Content/Sansation_Light.ttf');
            font-weight: 100;
        }

        p {
            font-weight: bold;
            font-family: myFont;
        }

        h1 {
            font-family: myFont;
            font-size: 2.5em;
        }

        #States, #Selection {
            display: none;
        }

        #lstSourceStates, #lstDestinationStates {         
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-family: myFont;
            font-weight: 400;
        }
    </style>
    <%--<script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            label1.Text = "you just visited the page.";
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            addResult.Text = "You just made a round trip to server, guess you didn't notice.";
        }
        
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="asm" runat="server" EnablePartialRendering="true" EnablePageMethods="true">
        </asp:ScriptManager>

        <div class="container" id="page-one">
            <div class="row" id="entry-row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-body">
                            <asp:TextBox CssClass="form-control" ID="txtBox" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="row jumbotron" id="result-row">
                <div class="col-md-3">
                    <asp:Label ID="label1" runat="server"></asp:Label>
                    <p>
                        <button class="btn btn-lg btn-primary" type="button" data-toggle="modal" data-target="#myModal">Take a Tour</button>
                    </p>
                </div>
                <div class="col-md-9">
                    <div class="row" id="add-row">
                        <div class="panel">
                            <div class="panel-body">
                                <div class="form-group">
                                    <asp:Label ID="lblNum1" runat="server" Text="Enter num 1" CssClass="control-label"></asp:Label>
                                    <asp:TextBox ID="txtNum1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="lblNum2" runat="server" Text="Enter num 2" CssClass="control-label"></asp:Label>
                                    <asp:TextBox ID="txtNum2" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success" />
                            </div>
                        </div>
                        <div class="row" id="add-resultrow">
                            <div class="panel">
                                <div class="panel-body">
                                    <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                        <ContentTemplate>
                                            <asp:Label ID="addResult" runat="server"></asp:Label>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="changePage" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <%--<asp:Label ID="addResult" runat="server"></asp:Label>--%>
                                    <p>
                                        <asp:Button ID="changePage" runat="server" Text="Magic of Ajax" CssClass="btn btn-error" OnClick="Button1_Click" />
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="container" id="page-two">
            <div class="page-header">
                <h1>Workflow Creation Wizard</h1>
            </div>
            <div class="row" id="Inititate">
                <div class="col-md-3" style="margin-top:10px; margin-left:30px;">
                    <button id="btnInitiate" class="btn btn-primary">Create New Workflow</button>
                </div>

            </div>
            <div class="row" id="States">
                <div class="col-md-3" style="margin-top:10px; margin-left:30px;">
                    <asp:TextBox ID="txtWorkflowName" runat="server" CssClass="form-control"></asp:TextBox>
                    <p style="margin-top: 10px;">
                        <asp:Button ID="btnSelectState" runat="server" CssClass="btn btn-success" Text="Show States" OnClientClick="return CheckWorkflowName();" OnClick="btnSelectState_Click" />
                    </p>
                </div>

            </div>

            <div class="row" id="Selection">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                    <ContentTemplate>
                        <div class="col-md-3" style="margin-top: 10px; margin-left: 30px;">
                            <h1 style="color: white;">Available states</h1>
                            <asp:ListBox ID="lstSourceStates" runat="server" Height="300px" Width="300px" SelectionMode="Multiple"></asp:ListBox>
                        </div>
                        <div class="col-md-2" style="margin-top: 10px;">
                            <asp:Button ID="InsertSelection" runat="server" CssClass="btn btn-danger" Enabled="true" Text="Insert" OnClick="InsertSelection_Click" />
                        </div>
                        <div class="col-md-5" style="margin-top: 10px;">
                            <div class="col-md-10">
                                <h1 style="color: white;">Selected workflow states</h1>
                                <asp:ListBox ID="lstDestinationStates" runat="server" Height="300px" Width="400px" SelectionMode="Multiple"></asp:ListBox>
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="DeleteSelection" runat="server" CssClass="btn btn-danger" Enabled="true" Text="Delete" OnClick="DeleteSelection_Click" />
                            </div>
                            
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSelectState" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="InsertSelection" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="DeleteSelection" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>

            </div>

        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">The Philosophy</h4>
                    </div>
                    <div class="modal-body">
                        <div class="well">
                            <h3>Well this is my first attempt to merge the two worlds of HTML5 and ASP.NET Web Forms and I can say that this feels more awesome than it sounds to be. Glad you came by and had a look.</h3>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                       
                    </div>
                </div>
            </div>
        </div>

    </form>

    <script type="text/javascript">

        function myfunction() {
            alertify.alert("Magic of Ajax");
        }

        function showSelection() {
            $("#Selection").velocity("transition.swoopIn", 1250);
        }

        function selectionError() {
            alertify.error("Please select workflow states");
        }

        function CheckWorkflowName() {
            if ($("#txtWorkflowName").val() == "") {
                $("#lstSourceStates").children().remove();
                $("#lstDestinationStates").children().remove();
                alertify.error("Please enter a workflow name");
                return false;
            }
            else {
                return true;
            }
        }

        function RemoveError() {
            alertify.error("Please select workflow states to delete");
        }

        $(document).ready(function () {

            $("#result-row").css("display", "none");
            $("#add-row").css("display", "none");
            $("#add-resultrow").css("display", "none");
            $("#txtWorkflowName").attr("placeholder", "Enter workflow name");

            $("#btnSubmit").click(function (e) {
                e.preventDefault();
                var value = $("#txtBox").val();
                if (value == "abhi") {
                    $.ajax({
                        url: 'http://localhost:51092/WebForm2.aspx/CallCode',
                        type: 'POST',
                        data: ' { value:"' + value + '" }',
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            $("#label1").html(data.d);
                            $("#result-row").velocity("transition.flipBounceYIn", 1250);
                            $("#add-row").velocity("transition.flipBounceYIn", 2250);
                            //alertify.alert("logged in");
                            //alertify.confirm("Want a tour around here ?")
                            //    .set('labels', { ok: 'Alright!', cancel: 'Naa!' })
                            //    .set('reverseButtons', true)
                            //    .set('onok', function () {
                            //        alertify.success('Ok');
                            //    })
                            //    .set('oncancel', function () {
                            //        alertify.error('Cancel');
                            //    });

                            //alertify.confirm("Want to take a tour ?",
                            //    function () {
                            //        $("#myModal").modal('toggle');
                            //    },
                            //    function () {
                            //        alertify.success('Ok');
                            //});

                        },
                        error: function (response) {
                            var r = jQuery.parseJSON(response.responseText);
                            alert("Message: " + r.Message);
                            alert("StackTrace: " + r.StackTrace);
                            alert("ExceptionType: " + r.ExceptionType);
                        }
                    });
                }
                else {
                    alertify.error("You cannot go further");
                }

            });

            $("#btnAdd").click(function (e) {
                e.preventDefault();
                var num1 = $("#txtNum1").val();
                var num2 = $("#txtNum2").val();
                $.ajax({
                    url: 'http://localhost:51092/WebForm2.aspx/AddMethod',
                    type: 'POST',
                    data: ' { num1:"' + num1 + '", num2:"' + num2 + '" }',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var result = "You wanted to add the numbers, well the sum is " + data.d;
                        $("#addResult").html(result);
                        $("#add-resultrow").velocity("transition.flipBounceYIn", 1250);
                        //alert(data.d);
                    },
                    error: function (response) {
                        var r = jQuery.parseJSON(response.responseText);
                        alert("Message: " + r.Message);
                        alert("StackTrace: " + r.StackTrace);
                        alert("ExceptionType: " + r.ExceptionType);
                    }
                });
            });

            $("#changePage").on('click', function () {
                $("#page-one").velocity("transition.bounceUpOut", 1250);
                $("#page-two").css("display", "block");
            });

            $("#page-two #page-header h1").on('click', function () {

                $("#page-two").velocity("transition.bounceDownOut", 1250);
                $("#page-one").velocity("transition.bounceUpIn", 1250);
            });

            $("#btnInitiate").on('click', function (e) {
                e.preventDefault();
                $("#States").velocity("transition.swoopIn", 1250);
            });

        });
    </script>

</body>
</html>
