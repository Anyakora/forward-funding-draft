// @sayscholar-doc FUND-ELIGIBILITY
export const ELIGIBILITY_STATUSES=['Potential now','After admission','After enrollment','After business launch','Ineligible','Needs verification'];
export function assessmentFor(x){const a=x?.fundingAudit?.eligibilityAssessment;return a&&ELIGIBILITY_STATUSES.includes(a.status)?a:{status:'Needs verification',reason:'Current eligibility has not been verified against the sponsor’s prerequisites.',blockingRequirements:[],sourceUrls:[]}}
export function potentiallyRelevant(x){return ['Potential now','After admission','After enrollment','After business launch'].includes(assessmentFor(x).status)}
export function eligibilityMatches(x,filter='relevant'){const s=assessmentFor(x).status;if(!filter||filter==='all')return true;if(filter==='relevant')return potentiallyRelevant(x);return s===filter}
export function eligibilitySummary(data){return Object.fromEntries(ELIGIBILITY_STATUSES.map(s=>[s,data.filter(x=>assessmentFor(x).status===s).length]))}
