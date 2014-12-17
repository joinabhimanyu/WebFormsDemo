<%@ Page Language="C#" AutoEventWireup="true" Inherits="WebFormsDemo.WebForm1" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="WebFormsDemo.Models" %>
<%@ Import Namespace="System.Web.Script.Services" %>

<%Page.Title = "Enquiry Page"; %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%:Page.Title %></title>
    <script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
    <style type="text/css">
   
     #progress1 {
      width: 400px; background-color: #000000; height:50px; text-align:center; border-radius: 3px; font-size: 1.2em; color: #fff;
      position: absolute; margin-top:200px; margin-left: 400px; opacity:0.8; cursor:pointer; font-weight:bold;
     }

        #progress1:hover {
            opacity:1.0; 
        }

    </style>
</head>
<body>

    <script runat="server">
    
        protected void Page_Load(object sender, EventArgs e)
        {
            label1.Text = "you just visited the page.";
        }
    
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(5000);
            label1.Text = "you clicked the server side button";    
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        [WebMethod]
        public static ProdResult GetProduct(string productid)
        {
            ProdResult prod = null;
            int? prodid = Convert.ToInt32(productid);
            var _db = new WebFormsDemo.Models.ProductContext();
            IQueryable<Product> query = _db.Products;
            if (prodid.HasValue && prodid > 0)
            {
                query = query.Where(p => p.ProductID == prodid);
                prod = new ProdResult();
                if (query.Count()>0)
                {
                    prod.ProductName = query.First().ProductName.Trim();
                    prod.Description = query.First().Description.Trim();
                    prod.ImagePath = query.First().ImagePath.Trim();
                }         
            }
            else
            {
                query = null;
            }
            return prod;   
                   
        }
    
    </script>

    <script type="text/javascript">

        function myfunction() {
            $("#label1").html("you clicked the client side button");
            
        }

        function CallService() {
            var productid = $("#txt_productid").val();
            if (productid == "") {
                alert("enter category id to proceed");
            }
            else {
                WebFormsDemo.DemoWebService.ReturnProduct(productid.trim(), OnWSRequestComplete, OnWSRequestError);

            }

        }

        function CallPageMethod() {
            var productid = $("#txt_productid").val();
            if (productid == "") {
                alert("enter product id to proceed");
            }
            else {
                $.ajax({

                    url: 'http://localhost:51092/WebForm1.aspx/GetProduct',
                    type: 'POST',
                    data: ' { productid:"' + productid + '" }',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        $("#lblprodname").html(data.d.ProductName);
                        $("#lbldescription").html(data.d.Description);
                        $("#image").attr("src", "Catalog/Images/" + data.d.ImagePath);
                        
                    },
                    error: function (response) {
                        var r = jQuery.parseJSON(response.responseText);
                        alert("Message: " + r.Message);
                        alert("StackTrace: " + r.StackTrace);
                        alert("ExceptionType: " + r.ExceptionType);
                    }

                });
            }
        }


        function OnWSRequestComplete(result) {
            var str = "";
            
                $.each(result, function (index, product) {

                    str = str + "<tr>";
                    var entry = "<td><img style='width:100px;height:100px;' src='Catalog/Images/" + product.ImagePath + "'/></td><td>" + product.ProductName + "</td><td>" + product.Description + "</td><td>" + product.UnitPrice + "</td></tr>";
                    str = str + entry;

                });
                $(".table tbody").html(str);
            }          
        


        function OnWSRequestError(error) {
            alert("Stack Trace: " + error.get_stackTrace() + "/r/n" +
                  "Error: " + error.get_message() + "/r/n" +
                  "Status Code: " + error.get_statusCode() + "/r/n" +
                  "Exception Type: " + error.get_exceptionType() + "/r/n" +
                  "Timed Out: " + error.get_timedOut());                
        }

    </script>

    <form id="form1" runat="server">
        <div class="container">
            <asp:ScriptManager ID="asm" runat="server" EnablePartialRendering="true" EnablePageMethods="true">
                <Services>
                    <asp:ServiceReference Path="~/DemoWebService.asmx" />
                </Services>
            </asp:ScriptManager> 
            
            <script type="text/javascript">

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                function CancelAsyncPostBack() {
                    if (prm.get_isInAsyncPostBack()) {
                        prm.abortPostBack();
                    }
                }

                prm.add_initializeRequest(InitializeRequest);
                prm.add_endRequest(EndRequest);
                var postBackElement;
                function InitializeRequest(sender, args) {
                    if (prm.get_isInAsyncPostBack()) {
                        args.set_cancel(true);
                    }
                    postBackElement = args.get_postBackElement();
                    if (postBackElement.id == 'btnSubmit') {
                        $get('progress1').style.display = 'block';
                    }
                }
                function EndRequest(sender, args) {
                    if (postBackElement.id == 'btnSubmit') {
                        $get('progress1').style.display = 'none';
                    }
                }

                

            </script>
             
        <div class="row" style="padding:10px;">
            <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                <ContentTemplate>
                    <asp:Label ID="label1" runat="server"></asp:Label>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
            <asp:UpdateProgress ID="progress1" runat="server" AssociatedUpdatePanelID="update1">
                <ProgressTemplate>
                    <div class="row">
                        <progress id="panel-progress"></progress>
                    </div>
                    <div class="row">
                        An update is in progress...
                    </div>
                    <div class="row" style="padding:3px;">
                        <input class="btn btn-primary" type="button" id="cancel-button" value="Cancel" onclick="CancelAsyncPostBack()" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        <div class="row">
            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="First Click" OnClick="btnSubmit_Click" />
            <button id="btnSecond" class="btn btn-primary" type="button" onclick="myfunction()">Second Click</button>
            <button id="btnReset" class="btn btn-primary" type="submit">Reset</button>
            <input type="text" id="txt_productid" />
            
        </div>
        </div>
    </form>

    <div class="row" style="margin-top:40px;margin-left:100px">
        <button id="btnService" class="btn btn-primary" onclick="CallService()">Call Web Service</button>
        <button id="btnPageMethod" class="btn btn-primary" onclick="CallPageMethod()">Call Page Method</button>
    </div>

    <div class="row" style="margin-top: 20px;margin-left:85px;">
        <div class="col-md-2">
            <img id="image" style="width:100px;height:100px;" class="img-thumbnail" src="Images/bullet.png" />
        </div>
        <div class="col-md-10">
            <div class="row">
                <label id="lblprodname"></label>
            </div>
            <div class="row">
                <label id="lbldescription"></label>
            </div>
        </div> 
    </div>

    <div class="row" id="ProductData" style="margin-top:20px;width:1000px;margin-left:100px;padding-bottom:50px;">
         <table class="table table-stripped table-bordered">
             <thead>
                <tr>
                    <th></th>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Unit Price</th>
                </tr>
             </thead>
             <tbody style="font-weight:400;color:brown;">   
             </tbody>
         </table>
    </div>
            
    
</body>
</html>
