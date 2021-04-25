using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WonderLabz.Models
{
    public class tblAccountRules
    { 
		[Key]
		public int RuleID { get; set; }
		[Column(TypeName = "int")] 
		public int RuleCode { get; set; }
		[Column(TypeName = "varchar(100)")] 
		public string RuleDescription { get; set; }
		[Column(TypeName = "money")] 
		public decimal Value { get; set; }
		[Column(TypeName = "bigint")] 
		public long CreatedBy { get; set; }
	}
}
