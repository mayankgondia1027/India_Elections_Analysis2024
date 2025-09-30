-- Total Seats
select distinct count(parliamentconstituency) as total_seats
from constituencywise_results;

-- What is the total number of seats available for elections in each state
select states.state as state_name, count(constituencywise_results.constituencyid) as total_seats_available
from constituencywise_results join statewise_results 
on constituencywise_results.parliamentconstituency = statewise_results.parliamentconstituency
join states on statewise_results.stateid = states.stateid
group by states.state order by states.state;

-- Total Seats Won by NDA Allianz
select sum(case when party in (  
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
			then `won` else 0 end) as nda_total_seats_won
from partywise_results;

-- Seats Won by NDA Allianz Parties
select party as Party_Name, won as Seats_won from partywise_results
where party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
order by Seats_Won desc;

-- Total Seats Won by I.N.D.I.A. Allianz
select sum(case when party in ( 
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
           then `won` else 0 end) as INDIA_total_seats_won
from partywise_results;

-- Seats Won by I.N.D.I.A. Allianz Parties
select party as Party_Name, won as Seats_won from partywise_results
where party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
order by Seats_won desc;

-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
alter table partywise_results
add party_alliance varchar(50);

-- I.N.D.I.A Allianz
update partywise_results
set party_alliance = 'I.N.D.I.A'
where party in (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK');
    
-- NDA Allianz
update partywise_results
set party_alliance = 'NDA'
where party in (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM');
    
-- OTHER
update partywise_results
set party_alliance = 'OTHER'
where party_alliance is NUll;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
select partywise_results.party_alliance,
count(constituencywise_results.constituencyid) as seats_won
from constituencywise_results join partywise_results
on constituencywise_results.partyid = partywise_results.partyid
where partywise_results.party_alliance in ('NDA', 'I.N.D.I.A', 'OTHER')
group by partywise_results.party_alliance order by seats_won desc;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
select constituencywise_results.winningcandidate, partywise_results.party, 
partywise_results.party_alliance, constituencywise_results.totalvotes, 
constituencywise_results.margin, constituencywise_results.constituencyname, states.state
from constituencywise_results join partywise_results 
on constituencywise_results.partyid = partywise_results.partyid
join statewise_results 
on constituencywise_results.parliamentconstituency = statewise_results.parliamentconstituency
join states
on statewise_results.stateid = states.stateid
where states.state = 'Uttar Pradesh' and constituencywise_results.constituencyname = 'AMETHI';

-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
select
    constituencywise_results.candidate,
    constituencywise_details.party,
    constituencywise_details.evmvotes,
    constituencywise_details.postalvotes,
    constituencywise_details.totalvotes,
    constituencywise_results.constituencyname
from constituencywise_details join constituencywise_results 
on constituencywise_details.constituencyid = constituencywise_results.constituencyid
where constituencywise_results.constituencyname = 'MATHURA'
order by constituencywise_details.totalvotes desc;

-- Which parties won the most seats in s State, and how many seats did each party win?
select partywise_results.party, count(constituencywise_results.constituencyid) as seats_won
from constituencywise_results join partywise_results
on constituencywise_results.partyid = partywise_results.partyid
join statewise_results  
on constituencywise_results.parliamentconstituency = statewise_results.parliamentconstituency
join states  
on statewise_results.stateid = states.stateid
where states.state = 'Andhra Pradesh'
group by partywise_results.party order by seats_won desc;

-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
select states.state as state_name,
    sum(case when partywise_results.party_alliance = 'NDA' then 1 else 0 end) as NDA_Seats_Won,
    sum(case when partywise_results.party_alliance = 'I.N.D.I.A'  then 1 else 0 end) as INDIA_Seats_Won,
    sum(case when partywise_results.party_alliance = 'OTHER' then 1 else 0 end) as OTHER_Seats_Won
from constituencywise_results 
join partywise_results  
on constituencywise_results .partyid = partywise_results.partyid
join statewise_results
on constituencywise_results .parliamentconstituency = statewise_results.parliamentconstituency
join states
on statewise_results.stateid = states.stateid
group by states.state order by states.state; 

-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?
select 
    constituencywise_results.constituencyname,
    constituencywise_details.constituencyid,
    constituencywise_details.candidate,
    constituencywise_details.evmvotes
from constituencywise_details join constituencywise_results 
on constituencywise_details.constituencyid = constituencywise_results.constituencyid
where constituencywise_details.evmvotes = (
        select max(constituencywise_details.evmvotes)
        from constituencywise_details 
        where constituencywise_details.constituencyid = constituencywise_details.constituencyid)
order by constituencywise_details.evmvotes desc limit 10;

-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
with rankedcandidates as (
    select 
        constituencywise_details.constituencyid,
        constituencywise_details.candidate,
        constituencywise_details.party,
        constituencywise_details.evmvotes,
        constituencywise_details.postalvotes,
        constituencywise_details.evmvotes + constituencywise_details.postalvotes as total_votes,
        row_number() over (partition by constituencywise_details.constituencyid 
            order by constituencywise_details.evmvotes + constituencywise_details.postalvotes desc) as voterank
    from constituencywise_details join constituencywise_results 
    on constituencywise_details.constituencyid = constituencywise_results.constituencyid
    join statewise_results 
    on constituencywise_results.parliamentconstituency = statewise_results.parliamentconstituency
    join states  
    on statewise_results.stateid = states.stateid
    where states.state = 'Maharashtra')
select 
    constituencywise_results.constituencyname,
    max(case when rankedcandidates.voterank = 1 then rankedcandidates.candidate end) as winning_candidate,
    max(case when rankedcandidates.voterank = 2 then rankedcandidates.candidate end) as runnerup_candidate,
    max(case when rankedcandidates.voterank = 3 then rankedcandidates.candidate end) as Secondrunnerup_candidate
from rankedcandidates join constituencywise_results 
    on rankedcandidates.constituencyid = constituencywise_results.constituencyid
group by constituencywise_results.constituencyname order by constituencywise_results.constituencyname;


-- For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
select 
    count(distinct constituencywise_results.constituencyid) as total_seats,
    count(distinct constituencywise_details.candidate) as total_candidates,
    count(distinct partywise_results.party) as total_parties,
    sum(constituencywise_details.evmvotes + constituencywise_details.postalvotes) as total_votes,
    sum(constituencywise_details.evmvotes) as total_evm_votes,
    sum(constituencywise_details.postalvotes) as total_postal_votes
from constituencywise_results join constituencywise_details 
on constituencywise_results.constituencyid = constituencywise_details.constituencyid
join statewise_results  
on constituencywise_results.parliamentconstituency = statewise_results.parliamentconstituency
join states 
on statewise_results.stateid = states.stateid
join partywise_results  
on constituencywise_results.partyid = partywise_results.partyid
where states.state = 'Maharashtra';