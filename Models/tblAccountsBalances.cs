using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WonderLabz.Models
{
    public class tblAccountsBalances
    {
        [Key]
        public long BalanceID { get; set; }
        [Column(TypeName = "bigint")]
        public long AccountID { get; set; }
         [Column(TypeName = "money")]
        public decimal Balance { get; set; } 
    
    }
}
