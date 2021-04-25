using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WonderLabz.Models
{
    public class tblTransactionHistory
    { 
		[Key]
		public long HistoryID { get; set; }
		[Column(TypeName = "bigint")] 
		public long AccountID { get; set; }
		[Column(TypeName = "nvarchar(500)")] 
		public string Action { get; set; }
		[Column(TypeName = "int")] 
		public int AccTypeID { get; set; }
		[Column(TypeName = "int")] 
		public int TransTypeID { get; set; }
		[Column(TypeName = "money")] 
		public decimal Debit { get; set; }
		[Column(TypeName = "money")] 
		public decimal Credit { get; set; }
		[Column(TypeName = "int")] 
		public int UserID { get; set; }

	}
}
