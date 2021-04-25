using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WonderLabz.Models
{
    public class tblTransferFunds
    {
        [Key]
        public int TransferID { get; set; }
        [Column(TypeName = "bigint")]
        public long FromAccount { get; set; }
        [Column(TypeName = "money")]
        public decimal Amount { get; set; }
        [Column(TypeName = "bigint")]
        public long ToAccount { get; set; }
         [Column(TypeName = "bigint")]
        public int AccountType { get; set; }
         [Column(TypeName = "bigint")]
        public int TransactionType { get; set; }
        [Column(TypeName = "varchar(150)")]
        public string Description { get; set; }
        [Column(TypeName = "bigint")]
        public int UserID { get; set; }
    }
}
