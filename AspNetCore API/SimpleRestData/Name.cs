using System;
using System.Runtime.Serialization;
using Newtonsoft.Json;

namespace SimpleRestData
{
    public class Name
    {
        [JsonProperty("id")]
        public Guid Id { get; set; }

        [JsonProperty("first_name")]
        public string FirstName { get; set; }

        [JsonProperty("last_name")]
        public string LastName { get; set; }

        [JsonProperty("update_time")]
        public DateTime UpdateTime { get; set; }

        [JsonProperty("removed")]
        public bool Removed { get; set; }
    }
}
