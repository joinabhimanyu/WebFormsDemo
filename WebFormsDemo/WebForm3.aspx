<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="WebFormsDemo.WebForm3" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Script.Services" %>
<%@ Import Namespace="Microsoft.AspNet.FriendlyUrls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Page 3</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.core.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.default.css" />
    <link rel="stylesheet" type="text/css" href="bower_components/sweetalert/lib/sweet-alert.css" />
    <link href='http://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="Content/uikit.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/uikit.gradient.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/uikit.almost-flat.min.css" />

    <%--<script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="Scripts/alertify.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.velocity.min.js"></script>
    <script type="text/javascript" src="Scripts/velocity.ui.js"></script>
    <script type="text/javascript" src="bower_components/sweetalert/lib/sweet-alert.min.js"></script>
    <script type="text/javascript" src="Scripts/uikit.min.js"></script>--%>

    <style type="text/css">
        body {
            background-color: white;
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
            display: block;
        }

        #entry-row, #result-row {
            margin-top: 10px;
        }

        #result-row {
            height: auto;
        }

        #txtWorkflowName {
            margin-top: 7px;
        }

        #btnSubmit {
            margin-top: 6px;
        }

        #lblWorkflowName {
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 44px;
            -webkit-transition: all 0.3s linear;
            -moz-transition: all 0.3s linear;
            -o-transition: all 0.3s linear;
            transition: all 0.3s linear;
        }

        /*@font-face {
            font-family: myFont;
            src: url('~/fonts/Sansation_Light.ttf');
        }*/


        p {
            font-weight: bold;
            /*font-family: myFont;*/
            font-family: 'Indie Flower', cursive;
        }

        h1 {
            font-family: 'Indie Flower', cursive;
            /*font-family: myFont;*/
            font-size: 2.5em;
            color: white;
        }

        h3 {
            font-family: 'Indie Flower', cursive;
            /*font-family: myFont;*/
            font-size: 2.5em;
            color: black;
        }

        #lblHeader {
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 2.1em;
            color: black;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="asm" runat="server" EnablePartialRendering="true" EnablePageMethods="true">

            <Scripts>

                <asp:ScriptReference Path="~/Scripts/jquery-1.10.2.min.js" />
                <asp:ScriptReference Path="~/Scripts/alertify.js" />
                <asp:ScriptReference Path="~/Scripts/bootstrap.min.js" />
                <asp:ScriptReference Path="~/Scripts/jquery.velocity.min.js" />
                <asp:ScriptReference Path="~/Scripts/velocity.ui.js" />
                <asp:ScriptReference Path="~/bower_components/sweetalert/lib/sweet-alert.min.js" />
                <asp:ScriptReference Path="~/Scripts/uikit.min.js" />

            </Scripts>

        </asp:ScriptManager>

        <div class="container" id="page-one">

            <div class="row" id="entry-row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-body">
                            <p class="well">
                                <asp:Label ID="lblHeader" CssClass="control-label" runat="server"></asp:Label>
                            </p>
                            
                            <div class="form-group" style="margin-top: 40px;">
                                <asp:Label ID="lblWorkflowName" runat="server" Text="Workflow Name" CssClass="control-label"></asp:Label>
                                <asp:TextBox ID="txtWorkflowName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <%--<p>
                                <asp:Button ID="btnGenerateFile" runat="server" Text="Generate File" CssClass="btn btn-success" />
                            </p>--%>
                            <ul class="list-inline">
                                <li>
                                    <asp:Button ID="btnReadFile" runat="server" CssClass="btn btn-primary" Text="Read File" OnClick="btnShowResult_Click" />
                                </li>
                                <li>
                                    <asp:Button ID="btnDisplayStateTransition" runat="server" CssClass="btn btn-primary" Text="Display in State Transition Pattern" OnClick="btnDisplayStateTransition_Click" />
                                </li>
                            </ul>
                           
                        </div>
                    </div>

                </div>
            </div>

            <div class="row" id="result-row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-body">
                            <asp:UpdatePanel ID="updStates" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                <ContentTemplate>

                                    <asp:GridView ID="grdStates" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" ItemType="WebFormsDemo.StateActivity">
                                        <Columns>

                                            <asp:TemplateField HeaderText="State Activity Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStateName" runat="server" Text='<%# Eval("state_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="EventDriven Activity Details">
                                                <ItemTemplate>

                                                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" ItemType="WebFormsDemo.EventDrivenActivity" DataSource='<%# Eval("event_driven") %>'>
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Event Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEventName" runat="server" Text='<%# Eval("eventname") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="HandleExternal Event Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblHandleEvent" runat="server" Text='<%# Eval("handleExternal") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="SetState Activity Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSetState" runat="server" Text='<%# Eval("setState") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>

                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnReadFile" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
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

        <div class="modal fade" id="modalStates" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="H1">Generated States</h4>
                    </div>
                    <div class="modal-body">
                        <div class="well">

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                <ContentTemplate>
                                    <asp:GridView ID="grdStateTransition" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" ItemType="WebFormsDemo.DisplayState">
                                        <Columns>
                                            <asp:TemplateField HeaderText="State Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblDisplayName" Text='<%# Eval("disp_state_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Target State Name">
                                                <ItemTemplate>
                                                    <asp:ListBox ID="listTargetStates" runat="server" CssClass="form-control" DataSource='<%# Eval("target_states") %>' Enabled="False"></asp:ListBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnDisplayStateTransition" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
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

        function ToggleModal() {
            $("#modalStates").modal('toggle');
        }

        function ShowResultRow(result) {
            if (result == "success") {
                $("#result-row").velocity("transition.slideUpIn", 1250);
            }
            else {
                alertify.alert('Please enter file name');
            }
        }

        function DisplayStateTransition(result) {
            if (result == "success") {
                $("#modalStates").modal('toggle');
            }
            else {
                sweetAlert('Oops!', result, 'error');
            }
        }

        $(document).ready(function () {

            $("#result-row").css("display", "none");

            $("#txtWorkflowName").attr("placeholder", "Enter the file path if different from default path");

            //$("#btnSubmit").click(function (e) {
            //    e.preventDefault();
            //    var value = $("#txtBox").val();
            //    if (value == "abhi") {
            //        $.ajax({
            //            url: 'http://localhost/WebFormsDemo/WebForm3.aspx/CheckUser',
            //            type: 'POST',
            //            data: ' { value:"' + value + '" }',
            //            dataType: 'json',
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {

            //                $("#label1").html(data.d);
            //                $("#result-row").velocity("transition.flipBounceYIn", 1250);
            //                $("#add-row").velocity("transition.flipBounceYIn", 2250);

            //            },
            //            error: function (response) {
            //                var r = jQuery.parseJSON(response.responseText);
            //                alertify.alert("Message: " + r.Message);
            //                alertify.alert("StackTrace: " + r.StackTrace);
            //                alertify.alert("ExceptionType: " + r.ExceptionType);
            //            }
            //        });
            //    }
            //    else {
            //        alertify.error("You cannot go further");
            //    }

            //});

            //$("#btnGenerateFile").click(function (e) {
            //    e.preventDefault();
            //    var workflowName = $("#txtWorkflowName").val();

            //    $.ajax({
            //        url: 'http://localhost/WebFormsDemo/WebForm3.aspx/GenerateFile',
            //        type: 'POST',
            //        data: ' { workflow_name:"' + workflowName + '" }',
            //        dataType: 'json',
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {

            //            var result = data.d;
            //            if (result == "success") {
            //                sweetAlert('Great!', 'File generated successfully', 'success');
            //            }
            //            else {
            //                sweetAlert('Oops!', 'Something went wrong', 'error');
            //            }
            //            //alert(data.d);
            //        },
            //        error: function (response) {
            //            var r = jQuery.parseJSON(response.responseText);
            //            alertify.alert("Message: " + r.Message);
            //            alertify.alert("StackTrace: " + r.StackTrace);
            //            alertify.alert("ExceptionType: " + r.ExceptionType);
            //        }
            //    });
            //});




        });

    </script>

</body>
</html>
