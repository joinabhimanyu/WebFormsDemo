using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFormsDemo.Models;


namespace WebFormsDemo
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<Catagory> GetCategories()
        {
            var _db = new WebFormsDemo.Models.ProductContext();
            IQueryable<Catagory> query = _db.Catagories;
            return query;
        }

    }
}