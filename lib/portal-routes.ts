import AUDIT from './portal-audit.json';
export function portalRoute(x:any){return (AUDIT as any[]).find(a=>a.id===x.id)?.applicationUrl||x.url}
export function portalLabel(x:any){return (AUDIT as any[]).find(a=>a.id===x.id)?.applicationUrl?'Application / entry page':'Sponsor page — route unverified'}
