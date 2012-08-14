using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Security;
using DotNetOpenAuth.OpenId.Extensions.SimpleRegistration;

namespace SocialPirates.Blackbeard.Site.Models
{

    public class ChangePasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class LoginModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        public bool RememberMe { get; set; }
    }

    public class RegisterModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email address")]
        public string Email { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class OpenIdUser
    {
        public string Email { get; set; }
        public string Nickname { get; set; }
        public string FullName { get; set; }
        public bool IsSignedByProvider { get; set; }
        public string ClaimedIdentifier { get; set; }

        public OpenIdUser(string data)
        {
            populateFromDelimitedString(data);
        }

        public OpenIdUser(ClaimsResponse claim, string identifier)
        {
            addClaimInfo(claim, identifier);
        }

        private void addClaimInfo(ClaimsResponse claim, string identifier)
        {
            Email = claim.Email;
            FullName = claim.FullName;
            Nickname = claim.Nickname ?? claim.Email;
            IsSignedByProvider = claim.IsSignedByProvider;
            ClaimedIdentifier = identifier;
        }

        private void populateFromDelimitedString(string data)
        {
            if (data.Contains(";"))
            {
                var stringParts = data.Split(';');
                if (stringParts.Length > 0) Email = stringParts[0];
                if (stringParts.Length > 1) FullName = stringParts[1];
                if (stringParts.Length > 2) Nickname = stringParts[2];
                if (stringParts.Length > 3) ClaimedIdentifier = stringParts[3];
            }
        }

        public override string ToString()
        {
            return String.Format("{0};{1};{2};{3}", Email, FullName, Nickname, ClaimedIdentifier);
        }
    }
}
