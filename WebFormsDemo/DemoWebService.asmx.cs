using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Handlers;
using WebFormsDemo.Models;
using System.Web.Script.Services;
using System.Data.Entity;


namespace WebFormsDemo
{
  
    [WebService(Namespace = "http://localhost:51092/DemoWebService.asmx")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)] 
    [System.Web.Script.Services.ScriptService]
    public class DemoWebService : System.Web.Services.WebService
    {

        [ScriptMethod(ResponseFormat=ResponseFormat.Json,UseHttpGet=true)]
        [WebMethod]
        public List<ProdResult> ReturnProduct(int? catagoryId)
        {
            var _db = new WebFormsDemo.Models.ProductContext();
            List<ProdResult> product = null;
            IQueryable<Product> query = _db.Products;
            if (catagoryId.HasValue && catagoryId > 0)
            {
                query = query.Where(p => p.CategoryID == catagoryId);
            }
            if (query.Count()>0)
            {
                IEnumerable<Product> penum = query.AsEnumerable<Product>();
                product = new List<ProdResult>();
                for (int i = 0; i < penum.Count(); i++)
                {
                    ProdResult prod = new ProdResult();
                    prod.ProductName = penum.ElementAt(i).ProductName.Trim();
                    prod.Description = penum.ElementAt(i).Description.Trim();
                    prod.ImagePath = penum.ElementAt(i).ImagePath.Trim();
                    prod.UnitPrice = penum.ElementAt(i).UnitPrice.ToString().Trim();
                    product.Add(prod);
                    prod = null;
                }
            }      
            return product;         
        }
    }
}
