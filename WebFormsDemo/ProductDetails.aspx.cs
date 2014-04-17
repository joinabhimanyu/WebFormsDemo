using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFormsDemo.Models;
using System.Web.ModelBinding;


namespace WebFormsDemo
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<Product> GetProduct([QueryString("productID")] int? productid)
        {
            var _db = new WebFormsDemo.Models.ProductContext();
            IQueryable<Product> query = _db.Products;
            if (productid.HasValue && productid > 0)
            {
                query = query.Where(p => p.ProductID == productid);
            }
            else
            {
                query = null;
            }
            return query;
        }

    }
}