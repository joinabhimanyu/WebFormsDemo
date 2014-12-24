<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebFormsDemo.WebForm2" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Script.Services" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Workflow Configuration Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.core.css" />
    <link rel="stylesheet" type="text/css" href="Content/alertify.default.css" />
    <link rel="stylesheet" type="text/css" href="bower_components/sweetalert/lib/sweet-alert.css" />
    <link href='http://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="Content/uikit.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/uikit.gradient.min.css" />
    <link rel="stylesheet" type="text/css" href="Content/uikit.almost-flat.min.css" />

    <script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="Scripts/alertify.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.velocity.min.js"></script>
    <script type="text/javascript" src="Scripts/velocity.ui.js"></script>
    <script type="text/javascript" src="bower_components/sweetalert/lib/sweet-alert.min.js"></script>
    <script type="text/javascript" src="Scripts/uikit.min.js"></script>

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


        #page-two {
            z-index: 9;
            display: block;
        }


        @font-face {
            font-family: myFont;
            src: url('~/fonts/Sansation_Light.ttf');
        }



        p {
            font-weight: bold;
            font-family: myFont;
        }

        h1 {
            /*font-family: 'Indie Flower', cursive;*/
            font-family: myFont;
            font-size: 2.5em;
            color: white;
        }

        #States, #Selection {
            display: none;
        }

        #lstSourceStates, #lstDestinationStates {
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            font-family: myFont;
            font-weight: bold;
            font-size: 1.2em;
            line-height: 1.5em;
            border-color: rgba(102,175,233,0.6);
            border-width:thin;
            -moz-transition: all 0.3s linear;
            -o-transition: all 0.3s linear;
            -webkit-transition: all 0.3s linear;
            transition: all 0.3s linear;
        }

            #lstSourceStates:hover {
                border-color: #66afe9;
                -moz-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
                -webkit-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
                box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
            }
            #lstDestinationStates:hover {
                border-color: #66afe9;
                -moz-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
                -webkit-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
                box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
            }

        .page-header {
            border-bottom: 1px solid hsla(225, 4%, 22%, 1);
        }

        .header {
            color: white;
        }

        #SetStateTransitions .well, #SetInitStates .well {
            -moz-transition: all 0.3s linear;
            -o-transition: all 0.3s linear;
            -webkit-transition: all 0.3s linear;
            transition: all 0.3s linear;
        }

        #SetStateTransitions .well:hover, #SetInitStates .well:hover {
            -moz-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
            -webkit-box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
            box-shadow: inset 4px 4px 4px rgba(0,0,0,0.075),4px 4px 8px rgba(102,175,233,0.6);
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="asm" runat="server" EnablePartialRendering="true" EnablePageMethods="true">
        </asp:ScriptManager>


        <div class="container" id="page-two">
            <%--<div class="page-header">
                
            </div>--%>
            <div class="row" style="background-color: #6f5499;">
                <div class="panel-heading">
                    <h1>Workflow Creation Wizard</h1>
                </div>

                    <div class="row" id="Inititate">
                        <div class="col-md-3" style="margin-top: 0px; margin-left: 30px;">
                            <p class="bg-success">
                                <button id="btnInitiate" class="btn btn-primary" data-toggle="modal" data-target="#workflow-name">
                                    <span class="glyphicon glyphicon-th-large" aria-hidden="true" style="text-align: right;"> CreateWorkflow</span>
                                </button>
                            </p>
                            
                        </div>

                    </div>
            </div>
                

            <div class="row" id="Selection" style="background-color: #d3d3d3;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                    <ContentTemplate>
                        <div class="row" style="margin-left: 40px; margin-top: 20px;">
                                <div class="col-md-4">
                                    <div class="panel panel-success">
                                        <div class="panel-heading">
                                            <h2 class="header">Available states</h2>
                                        </div>
                                        <div class="panel-body">
                                    
                                    <asp:ListBox ID="lstSourceStates" CssClass="form-control" runat="server" Height="300px" Width="390px" SelectionMode="Multiple"></asp:ListBox>

                                        </div>
                                    </div>
                                    
                                </div>
                                
                                <div class="col-md-1" style="margin-left:12px;">
                                    <p>
                                        <asp:Button ID="InsertSelection" runat="server" CssClass="btn btn-success" Enabled="true" Text="Insert" OnClick="InsertSelection_Click" />
                                    </p>
                                    <p>
                                        <asp:Button ID="DeleteSelection" runat="server" CssClass="btn btn-success" Enabled="true" Text="Delete" OnClick="DeleteSelection_Click" />
                                    </p>
                                </div>
                        
                                <div class="col-md-4">
                                    <div class="panel panel-success">
                                        <div class="panel-heading">
                                            <h2 class="header">Selected workflow states</h2>
                                        </div>
                                        <div class="panel-body">
                                    
                                    <asp:ListBox ID="lstDestinationStates" CssClass="form-control" runat="server" Height="300px" Width="390px" SelectionMode="Multiple"></asp:ListBox>

                                        </div>
                                    </div>
                                    
                                </div>
                        </div>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-md-2" style="margin-left: 300px;margin-bottom: 20px;">
                                <asp:Button ID="btnSetStateTransition" runat="server" CssClass="btn btn-success" Text="Set State Transitions" OnClientClick="return CheckDestinationStates();" OnClick="chk_Transition_CheckedChanged" />
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

            <div class="panel panel-default" id="Options-row" style="display: none; margin-top: 30px;background-color: #d3d3d3;">
                <div class="panel-heading" style="background: #6f5499;">
                    <h2 class="header">Workflow States</h2>
                </div>
                <div class="panel-body" style="margin-top: 8px;background-color: #d3d3d3;">
                <div class="row">
                <div class="col-md-6">
                    <div class="row" id="SetStateTransitions">
                <div class="col-md-7 well" style="margin-left: 43px;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <p>
                                <asp:DropDownList ID="ddlDisplayLinks" runat="server" Height="25px"
                                    Width="250px" Visible="true" AutoPostBack="True" OnSelectedIndexChanged="ddlDisplayLinks_SelectedIndexChanged">
                                </asp:DropDownList>
                            </p>
                            <div style="height: 200px; overflow-y: auto;">
                                <asp:CheckBoxList ID="chkSelectedLinks" runat="server" Height="23px"
                                    Width="300px" Visible="true">
                                </asp:CheckBoxList>
                            </div>
                            <p>
                                <asp:Button ID="btn_SaveChanges" runat="server" CssClass="btn btn-success" Text="Save Changes" OnClientClick="return CheckSaveChanges();" OnClick="btn_SaveChanges_Click" />
                            </p>
                        </ContentTemplate>

                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSetStateTransition" EventName="Click" />
                        </Triggers>

                    </asp:UpdatePanel>
                </div>

            </div>
                </div>
                <div class="col-md-6">
                    <div class="row" id="SetInitStates">
                <div class="col-md-7 well" style="margin-left: -60px;">
                    <h3>Set Initial State</h3>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <div style="height: 200px; overflow-y: auto;">
                                <asp:RadioButtonList ID="rdbSetInitStates" runat="server" Height="23px" Width="300px"></asp:RadioButtonList>
                            </div>
                            <p>
                                <asp:Button ID="CreateFile" runat="server" CssClass="btn btn-success" Text="Create File" OnClientClick="return AllowFileCreation();" OnClick="CreateFile_Click" />
                            </p>

                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CreateFile" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btn_SaveChanges" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

            </div>
                </div>
            </div>
            </div>
            </div>
            
            

        </div>

        <!-- Modal -->

        <div class="modal fade" id="workflow-name" tabindex="-1" role="dialog" aria-labelledby="workflow-label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="workflow-label">Workflow Name</h4>
                    </div>
                    <div class="modal-body">
                        <div class="well">
                            <p style="margin-top: 8px;">
                                <asp:TextBox ID="txtWorkflowName" runat="server" CssClass="form-control"></asp:TextBox>
                            </p>
                            <p style="margin-top: 8px;">
                                <asp:TextBox ID="txtPath" runat="server" CssClass="form-control"></asp:TextBox>
                            </p>
                            <p style="margin-top: 10px;">
                                <asp:Button ID="btnSelectState" runat="server" CssClass="btn btn-success" Text="Show States" OnClientClick="return CheckWorkflowName();" OnClick="btnSelectState_Click" />
                            </p>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </form>

    <script type="text/javascript">

        var countSavechanges = 0;


        function ShowStateTransitionPanel() {
            $("#Options-row").velocity("transition.slideUpIn", 1250);
            $("#SetStateTransitions").velocity("transition.flipBounceYIn", 1250);
            $("#SetInitStates").velocity("transition.flipBounceYIn", 2150);
            
            setTimeout('scroll()', 200);
        }

        function scroll() {
            $('html, body').animate({
                scrollTop: $("#Options-row").offset().top
            }, 1000);
        }

        function showSelection() {
            $("#Selection").velocity("transition.slideUpIn", 1250);
        }

        function selectionError() {
            alertify.error("Please select workflow states to insert");
        }

        function CheckWorkflowName() {

            if ($("#txtWorkflowName").val() == "") {
                $("#lstSourceStates").children().remove();
                $("#lstDestinationStates").children().remove();
                $("#Selection").velocity("transition.slideUpOut", 1250);
                alertify.error("Please enter a workflow name");
                return false;
            }
            else {
                
                var workflowName = $("#txtWorkflowName").val();
                //var pattern = /^[a-zA-Z]([a-zA-z0-9_-]){0,}/;
                var pattern = /[^0-9a-zA-Z\-\/]/;
                if (pattern.test(workflowName)) {
                    $("#lstSourceStates").children().remove();
                    $("#lstDestinationStates").children().remove();
                    $("#Selection").velocity("transition.slideUpOut", 1250);
                    alertify.error("Invalid workflow name");
                    return false;      
                }
                else {
                    if ($("#txtPath").val() == "") {

                        $("#lstSourceStates").children().remove();
                        $("#lstDestinationStates").children().remove();
                        $("#Selection").velocity("transition.slideUpOut", 1250);
                        alertify.error("Please enter a path");
                        return false;
                    }
                    else {
                        var path = $("#txtPath").val();
                        //var pattern = /^[a-zA-Z]([a-zA-z0-9_-]){0,}/;
                        var pattern = /[^0-9a-zA-Z\-:\\/]/;
                        if (pattern.test(path)) {
                            $("#lstSourceStates").children().remove();
                            $("#lstDestinationStates").children().remove();
                            $("#Selection").velocity("transition.slideUpOut", 1250);
                            alertify.error("Invalid path");
                            return false;
                        }
                        else {

                            $("#workflow-name").modal('toggle');
                            return true;
                        }
                    }
                    //$("#workflow-name").modal('toggle');
                    //return true;           
                }
            }

            

        }

        function RemoveError() {
            alertify.error("Please select workflow states to delete");
        }

        function CheckDestinationStates() {
            if ($("#lstDestinationStates").children().length == 0) {
                alertify.error("Please select states to continue");
                return false;
            }
        }

        function AllowFileCreation() {
            var count = 0;
            $("#rdbSetInitStates tr").each(function () {
                if ($(this).find("input:radio").prop('checked')) {
                    count = count + 1;
                }
            });
            if (count > 0 & countSavechanges > 0) {
                return true;
            }
            else {
                alertify.error("No states selected for file creation");
                return false;
            }
        }

        function CheckSaveChanges() {
            var count = 0;
            $("#chkSelectedLinks tr").each(function () {
                if ($(this).find("input:checkbox").prop('checked')) {
                    count = count + 1;
                }
            });
            if (count === 0) {
                alertify.error('Please select a state to continue');
                return false;
            }
            else {
                countSavechanges = countSavechanges + 1;
                return true;
            }
        }

        function CheckFileCreate(result, fileName) {
            if (result == "success") {
                //sweetAlert('Congratulations!', 'File generated successfully', 'success');
                swal({
                    title: 'File generated successfully',
                    text: 'Do you want to download the file ?',
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, download it!',
                    cancelButtonText: "No, don't download",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm) {

                    if (isConfirm) {
                        swal({
                            title: 'Congrats!',
                            text: 'File ready for download, click to initiate',
                            type: 'success',
                            confirmButtonText: 'Ok',
                            closeOnConfirm: false,
                        },
                        function () {
                            window.location = "DownloadFile.ashx?param=" + fileName;     
                        });
                    }
                    else {
                        window.location.reload();
                    }

                });
            }
            else {
                sweetAlert('Oops!', 'Something went wrong', 'error');
            }
        }

        function ChangeSaved() {
            alertify.success('Changes saved successfully');
        }

        $(document).ready(function () {

            $("#txtWorkflowName").attr("placeholder", "Enter workflow name");
            $("#txtPath").attr("placeholder","Enter path to generate the file");
            $("#SetStateTransitions").css("display", "none");
            $("#SetInitStates").css("display", "none");


        });
    </script>

</body>
</html>
