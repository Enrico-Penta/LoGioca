using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using LoGioca.Models;
using Microsoft.Extensions.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using LoGioca.DAL.Models;
using LoGioca.BLL.Service;
using LoGioca.BLL.DTOs;
using Microsoft.AspNetCore.Http;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace LoGioca.Controllers
{
    public class LoGiocaEmailController : BaseController
    {
        public LoGiocaEmailController(IConfiguration configuration,
            IHttpContextAccessor httpContextAccessor
            ) : base(configuration, httpContextAccessor)
        {

            IConfiguration _config = configuration;
        }
        public async Task<bool> SendMailInsert(int idUser, string data, string nome, int? postazione, string appartamento)
        {
            TimeZoneInfo fusoorario = TimeZoneInfo.FindSystemTimeZoneById("Central Europe Standard Time");

            DateTime local = TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(data), fusoorario);

            //LbUtente User = db.LbUtente.Where(x => x.Utenteid == idUser).FirstOrDefault();
            string mailto = /*db.LBRelazioneTipoContatto.Where(x => x.Id_Utente == idUser && x.Id_TipoContatto == 3).FirstOrDefault().Descrizione*/;
            var apiKey = "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";
            var client = new SendGridClient(apiKey);
            var msg = new SendGridMessage()
            {
                From = new EmailAddress("logibox@logicainformatica.it", "LogiBox Team"),
                Subject = "Check In " + local.ToString("dd/MM/yyyy") + "!",
                PlainTextContent = "",
                HtmlContent = 
            };
            msg.AddTo(new EmailAddress(mailto, User.Nome));
            var response = await client.SendEmailAsync(msg);

            return true;
        }



        //[HttpGet("SendMailDelete")]
        //public async Task<bool> SendMailDelete(int idUser, string data)
        //{
        //    TimeZoneInfo fusoorario = TimeZoneInfo.FindSystemTimeZoneById("Central Europe Standard Time");

        //    DateTime local = TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(data), fusoorario);

        //    //LbUtente User = db.LbUtente.Where(x => x.Utenteid == idUser).FirstOrDefault();
        //    string mailto = db.LBRelazioneTipoContatto.Where(x => x.Id_Utente == idUser && x.Id_TipoContatto == 3).FirstOrDefault().Descrizione;
        //    var apiKey = "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";
        //    var client = new SendGridClient(apiKey);
        //    var msg = new SendGridMessage()
        //    {
        //        From = new EmailAddress("logibox@logicainformatica.it", "LogiBox Team"),
        //        Subject = "Check Out " + local.ToString("dd/MM/yyyy") + " :(",
        //        PlainTextContent = "",
        //        HtmlContent =
        //    };
        //    msg.AddTo(new EmailAddress(mailto, User.Nome));
        //    var response = await client.SendEmailAsync(msg);

        //    return true;


        }
    }
}









