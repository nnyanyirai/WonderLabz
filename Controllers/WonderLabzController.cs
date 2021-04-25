using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WonderLabz.Models;

namespace WonderLabz.Controllers
{
    public class WonderLabzController : Controller
    {
        private readonly WonderLabzContext _context;
        public WonderLabzController(WonderLabzContext context)
        {
            _context = context;
        }

        [HttpPost]
        [Route("api/CreateClientAccounts")]
        public async Task<IActionResult> tblClientAccounts([FromBody] tblClientAccounts tblClientAccounts)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            
            tblClientAccounts.AccountNo = "ACCNO" + DateTime.Now.ToString("ddMMyyyyHHmmss");
            tblClientAccounts.AccountStatus = (int)AccountStatus.inactive;
            _context.tblClientAccounts.Add(tblClientAccounts);
            await _context.SaveChangesAsync();
            return Ok(new
            {
                Message = "You have successfully saved",
                ResponseBody = tblClientAccounts,
                StatusCode = "200"
            });
        }  
        [HttpGet]
        [Route("api/getClientAccounts")]
          public IEnumerable<tblClientAccounts> getClientAccounts()
        {
            return _context.tblClientAccounts;
        }
        // deposits, withdrawals, transfers,balance opening

        [HttpPost]
        [Route("api/AcountOpening")]
        public async Task<IActionResult> AcountOpening([FromBody] tblTransactionHistory tblTransactionHistory)
        {
            var openingDeposity = _context.tblAccountRules
                .Where(p => p.RuleCode == (int)TransactionRules.OpeningAccount).FirstOrDefault();

            var Status = _context.tblClientAccounts
                                        .Where(p => p.AccountID == tblTransactionHistory.AccountID).FirstOrDefault();
            if(Status.AccountStatus == (int)AccountStatus.inactive)
            {
                if(tblTransactionHistory.Credit >= openingDeposity.Value)
                {
                    Status.AccountStatus = (int)AccountStatus.active;  
                    tblTransactionHistory.TransTypeID = (int)transactionTypes.Opening;
                    tblTransactionHistory.Action = "Initial deposity for Account Opening of " + tblTransactionHistory.Credit.ToString("N3");
                }
            _context.tblTransactionHistory.Add(tblTransactionHistory);
            tblAccountsBalances balance = new tblAccountsBalances();
            balance.AccountID = tblTransactionHistory.AccountID;
            balance.Balance = tblTransactionHistory.Credit;    
            _context.tblAccountsBalances.Add(balance);
           
            }
             await _context.SaveChangesAsync();
            return Ok(new
            {
                Message = "You have Opened a new account, please proceed to activate it by depositing a minimum of " + openingDeposity.Value.ToString("N3"),
                ResponseBody = tblTransactionHistory,
                StatusCode = "200"
            });
        } 
        [HttpPost]
        [Route("api/Deposit")]
        public async Task<IActionResult> Deposit([FromBody] tblTransactionHistory tblTransactionHistory)
        {
           var Status = _context.tblClientAccounts
                                        .Where(p => p.AccountID == tblTransactionHistory.AccountID).FirstOrDefault();
            if(Status.AccountStatus == (int)AccountStatus.active)
            {
                    Status.AccountStatus = (int)AccountStatus.active;  
                    tblTransactionHistory.TransTypeID = (int)transactionTypes.Opening;
                    tblTransactionHistory.Action = "Deposity of " + tblTransactionHistory.Credit.ToString("N3");
            }
            
            _context.tblTransactionHistory.Add(tblTransactionHistory);
            var bal = _context.tblAccountsBalances
                                       .Where(p => p.AccountID == tblTransactionHistory.AccountID).FirstOrDefault();

          
            bal.AccountID = tblTransactionHistory.AccountID;
            bal.Balance = bal.Balance + tblTransactionHistory.Credit;    
            _context.tblAccountsBalances.Update(bal);
           await _context.SaveChangesAsync();
            return Ok(new
            {
                Message = "You have successfully deposited",
                ResponseBody = tblTransactionHistory,
                StatusCode = "200"
            });
        }
        [HttpPost]
        [Route("api/Withdrawal")]
        public async Task<IActionResult> Withdrawal([FromBody] tblTransactionHistory tblTransactionHistory)
        {
            var overDraft = _context.tblAccountRules
                .Where(p => p.RuleCode == (int)TransactionRules.OverdraftLimit).FirstOrDefault();
            var AccStatus = _context.tblClientAccounts
                                         .Where(p => p.AccountID == tblTransactionHistory.AccountID).FirstOrDefault();
           if(AccStatus.AccountStatus == (int)AccountStatus.active)
            {
                var bal = _context.tblAccountsBalances
                    .Where(p => p.AccountID == tblTransactionHistory.AccountID).FirstOrDefault();
                if (tblTransactionHistory.Debit <= (bal.Balance + overDraft.Value))
                {
                    tblTransactionHistory.TransTypeID = (int)transactionTypes.Withdrawal;
                    tblTransactionHistory.Action = "Withidrawn an amount of " + tblTransactionHistory.Debit.ToString("N3");
                    _context.tblTransactionHistory.Add(tblTransactionHistory); 
                    bal.Balance = bal.Balance - tblTransactionHistory.Debit;
                    bal.AccountID = tblTransactionHistory.AccountID;
                }
                   _context.tblAccountsBalances.Update(bal);
                    await _context.SaveChangesAsync();
                 
            }
            return Ok(new
            {
                Message = "You have successfully Withdrawn",
                ResponseBody = tblTransactionHistory,
                StatusCode = "200"
            });
        }
        [HttpPost]
        [Route("api/TransferFunds")]
        public async Task<IActionResult> TransferFunds([FromBody] tblTransferFunds transferFunds)
        {
            var FromAccStatus = _context.tblClientAccounts
                                         .Where(p => p.AccountID == transferFunds.FromAccount).FirstOrDefault();
            var ToAccStatus = _context.tblClientAccounts
                                         .Where(p => p.AccountID == transferFunds.ToAccount).FirstOrDefault();
        if (FromAccStatus.AccountStatus == (int)AccountStatus.active && ToAccStatus.AccountStatus== (int)AccountStatus.active)
            {
             // internal transfer
                var balFrom = _context.tblAccountsBalances
                   .Where(p => p.AccountID == transferFunds.FromAccount).FirstOrDefault();
                 var balTo = _context.tblAccountsBalances
                   .Where(p => p.AccountID == transferFunds.ToAccount).FirstOrDefault();
               if (transferFunds.Amount <= balFrom.Balance)
                {
                    tblTransactionHistory history = new tblTransactionHistory();
                    history.TransTypeID = transferFunds.TransactionType;
                    history.AccountID = transferFunds.FromAccount;
                    history.AccTypeID = transferFunds.AccountType;
                    history.Debit = transferFunds.Amount;
                    history.Action = "Internal transfer from account ID: " +  balFrom.AccountID.ToString("N3") + " to account ID: " + balTo.AccountID.ToString("N3") ;
                    history.UserID = transferFunds.UserID;
                    _context.tblTransactionHistory.Add(history);
                    balFrom.Balance = balFrom.Balance - transferFunds.Amount;
                    balTo.Balance = balFrom.Balance + transferFunds.Amount;
                    balFrom.AccountID = transferFunds.FromAccount;
                    _context.tblAccountsBalances.Update(balFrom);

                }
                         }
             await _context.SaveChangesAsync();
             return Ok(new
            {
                Message = "You have successfully transferred funds",
                ResponseBody = transferFunds,
                StatusCode = "200"
            });
        }
    
    }
}
