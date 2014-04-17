using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using WebFormsDemo.Models;

namespace WebFormsDemo.Models
{
    public class ProductContext : DbContext
    {
        public ProductContext()
            : base("WingtipToys")
        {
        }

        public DbSet<Catagory> Catagories { get; set; }
        public DbSet<Product> Products { get; set; }
    }
}