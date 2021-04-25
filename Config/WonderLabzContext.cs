using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WonderLabz.Models;

namespace WonderLabz
{
    public class WonderLabzContext : DbContext
    {
        public WonderLabzContext(DbContextOptions<WonderLabzContext> options) : base(options)
        {

        }
       public DbSet<tblClientAccounts> tblClientAccounts { get; set; }
       public DbSet<tblAccountRules> tblAccountRules { get; set; }
       public DbSet<tblAccountsBalances> tblAccountsBalances { get; set; }
        public DbSet<tblTransactionHistory> tblTransactionHistory { get; set; }
        public DbSet<tblTransferFunds> tblTransferFunds { get; set; }
    }
}
