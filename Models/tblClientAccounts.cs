using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WonderLabz.Models
{
	public class tblClientAccounts
	{ 
		[Key]
		public long AccountID { get; set; }
		[Column(TypeName = "nvarchar(20)")] 
		public string AccountNo { get; set; }
		[Column(TypeName = "nvarchar(500)")] 
		public string AccName { get; set; }
		[Column(TypeName = "nvarchar(500)")] 
		public string StreetAddress { get; set; }
		[Column(TypeName = "bigint")] 
		public long TownCity { get; set; }
		[Column(TypeName = "bigint")] 
		public long Country { get; set; }
		[Column(TypeName = "bigint")] 
		public long AccTypeID { get; set; }
		[Column(TypeName = "bigint")] 
		public long TransTypeID { get; set; }
		[Column(TypeName = "int")] 
		public int AccountStatus { get; set; }
		[Column(TypeName = "bigint")] 
		public long ProcessedBy { get; set; }
	}
}